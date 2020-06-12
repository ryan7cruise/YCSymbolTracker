//
//  YCSymbolTracker.m
//  YCSymbolTracker
//
//  Created by ycpeng on 2020/6/10.
//

#import "YCSymbolTracker.h"

#import <stdint.h>
#import <stdio.h>
#import <sanitizer/coverage_interface.h>
#import <libkern/OSAtomic.h>
#import <dlfcn.h>

void __sanitizer_cov_trace_pc_guard_init(uint32_t *start, uint32_t *stop) {
  static uint64_t N;  // Counter for the guards.
  if (start == stop || *start) return;  // Initialize only once.
//  printf("INIT: %p %p\n", start, stop);
  for (uint32_t *x = start; x < stop; x++)
    *x = (uint32_t)++N;  // Guards should start from 1.
}

void printInfo(void *PC) {
    Dl_info info;
    dladdr(PC, &info);
    printf("fnam:%s \n fbase:%p \n sname:%s \n saddr:%p \n",
           info.dli_fname,
           info.dli_fbase,
           info.dli_sname,
           info.dli_saddr);
}

static OSQueueHead symbolList = OS_ATOMIC_QUEUE_INIT;

typedef struct {
    void *pc;
    void *next;
} SymbolNode;

void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {
    if (!*guard) return;  // Duplicate the guard check.
    
    void *PC = __builtin_return_address(0);
    
    SymbolNode * node = malloc(sizeof(SymbolNode));
    *node = (SymbolNode){PC, NULL};
    
    OSAtomicEnqueue(&symbolList, node, offsetof(SymbolNode, next));

//    printInfo(PC);
}

@implementation YCSymbolTracker

+ (BOOL)exportSymbolsWithFilePath:(nonnull NSString *)filePath
{
    NSMutableArray <NSString *>* symbolNames = [NSMutableArray array];
    while (YES) {
        SymbolNode *node = OSAtomicDequeue(&symbolList, offsetof(SymbolNode, next));
        if (node == NULL) {
            break;
        }
        Dl_info info;
        dladdr(node->pc, &info);
        
        NSString * name = @(info.dli_sname);
        BOOL isObjc = [name hasPrefix:@"+["] || [name hasPrefix:@"-["]; // Objective-C method do nothing
        NSString * symbolName = isObjc? name : [@"_" stringByAppendingString:name]; // c function with "_"
        [symbolNames addObject:symbolName];
    }
    
    NSEnumerator * emt = [symbolNames reverseObjectEnumerator];
    NSMutableArray<NSString*>* funcs = [NSMutableArray arrayWithCapacity:symbolNames.count];
    NSString * name;
    while (name = [emt nextObject]) {
        if (![funcs containsObject:name]) {
            [funcs addObject:name];
        }
    }
    // remove current method symbol (not necessary when launch)
    [funcs removeObject:[NSString stringWithFormat:@"%s", __FUNCTION__]];
    
    NSString *funcStr = [funcs componentsJoinedByString:@"\n"];
    NSData * fileContents = [funcStr dataUsingEncoding:NSUTF8StringEncoding];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    return [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileContents attributes:nil];
}

@end
