//
//  SwiftDemo.swift
//  YCLaunchSymbolTracker
//
//  Created by ycpeng on 2020/6/10.
//  Copyright © 2020 彭雨晨. All rights reserved.
//

import UIKit

class SwiftDemo: NSObject {
    @objc class public func swiftTestLoad(){
        print(#function);
        
        SwiftTest.classTestDescription()
        
        SwiftTest().instanceDescription()
    }
}

class SwiftTest {
    static func classTestDescription() {
        print(#function);
    }
    
    func instanceDescription() {
        print(#function);
    }
}
