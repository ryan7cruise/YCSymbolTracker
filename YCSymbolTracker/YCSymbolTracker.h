//
//  YCSymbolTracker.h
//  YCSymbolTracker
//
//  Created by ycpeng on 2020/6/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCSymbolTracker : NSObject

+ (BOOL)exportSymbolsWithFilePath:(nonnull NSString *)filePath NS_SWIFT_NAME(exportSymbols(filePath:));

@end

NS_ASSUME_NONNULL_END
