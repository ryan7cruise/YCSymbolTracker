# YCSymbolTracker

[![CocoaPods](https://img.shields.io/badge/pod-0.1.0-green.svg)](https://github.com/ryan7cruise/YCSymbolTracker)
[![Platform](https://img.shields.io/badge/platform-iOS-green.svg)](https://github.com/ryan7cruise/YCSymbolTracker)
[![Support](https://img.shields.io/badge/support-iOS%208.0%2B-green.svg)](https://github.com/ryan7cruise/YCSymbolTracker)
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/ryan7cruise/YCSymbolTracker/blob/master/LICENSE)

## Brief

This library provides a tracker to track symbols when your app is running. It helps you to export the ordered symbols file which you can use in **Build Settings** → **Link** → **Order File**.

## Installation

**YCSymbolTracker** is available through [CocoaPods](https://cocoapods.org). 

To install it, simply add the following line to your Podfile:

```ruby
pod 'YCSymbolTracker'
```

If you want to track symbols of other static/dynamic libraries, you have to add more lines to your Podfile:

If using **use_frameworks!**

```ruby
post_install do |installer|
    require './Pods/YCSymbolTracker/YCSymbolTracker/symbol_tracker.rb'
    symbol_tracker(installer)
end
```

else 

You have to make sure that **YCSymbolTracker is a dynamic framework**.

There is a simple way to do that:

install [cocoapods-packing-cubes](https://github.com/segiddins/cocoapods-packing-cubes):

```shell
$ gem install cocoapods-packing-cubes
```

add the following lines to your Podfile:

```ruby
plugin 'cocoapods-packing-cubes',
'YCSymbolTracker' => { 'linkage' => 'dynamic', 'packaging' => 'framework' }
```

end

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Objective C

```objc
#import <YCSymbolTracker/YCSymbolTracker.h>

NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"demo.order"];
[YCSymbolTracker exportSymbolsWithFilePath:filePath];
```

#### Swift

```swift
import YCSymbolTracker

let filePath = NSTemporaryDirectory().appending("/demo.order")
YCSymbolTracker.exportSymbols(filePath: filePath)
```

Once you export the file, the work is done. You can remove this library in Podfile, and run `pod install` .



## License

YCSymbolTracker is available under the MIT license. See the LICENSE file for more info.



---



## 简介

在进行二进制重排的时候，需要导出启动时调用循序的符号表。这个工具就是用来导出这个符号表的，拿到符号表后在**Build Settings** → **Link** → **Order File** 中配置导出的 `xx.order` 文件路径就可以了。



## 安装

**YCSymbolTracker** 可以通过 [CocoaPods](https://cocoapods.org) 进行安装。

在Podfile中添加以下代码:

```ruby
pod 'YCSymbolTracker'
```

如果需要跟踪其他三方库的符号，需要添加下面的代码:

① 如果在Podfile中使用了**use_frameworks!** (Pods使用动态库)

```ruby
post_install do |installer|
    require './Pods/YCSymbolTracker/YCSymbolTracker/symbol_tracker.rb'
    symbol_tracker(installer)
end
```

② 如果不使用**use_frameworks!** (Pods使用静态库)，那么我们需要保证**YCSymbolTracker**是动态库。

安装pods的插件 [cocoapods-packing-cubes](https://github.com/segiddins/cocoapods-packing-cubes) 可以轻松地搞定这个问题：

```shell
$ gem install cocoapods-packing-cubes
```

然后在Podfile中添加下面的代码，指定**YCSymbolTracker**为动态库：

```ruby
plugin 'cocoapods-packing-cubes',
'YCSymbolTracker' => { 'linkage' => 'dynamic', 'packaging' => 'framework' }
```

## 教程

### Objective C

```objc
#import <YCSymbolTracker/YCSymbolTracker.h>

NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"demo.order"];
[YCSymbolTracker exportSymbolsWithFilePath:filePath];
```

#### Swift

```swift
import YCSymbolTracker

let filePath = NSTemporaryDirectory().appending("/demo.order")
YCSymbolTracker.exportSymbols(filePath: filePath)
```

导出文件之后，就可以把Podfile中相关的配置删掉了，然后执行 `pod install` 。