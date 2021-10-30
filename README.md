## 问题和需求

在一些iOS项目中，有时要对一个单例类由各模块在加载时对其进行一些操作，如注册动作。尤其这个单例是负责路由功能，其他模块加载往其注册相关路由。这样其他模块没有打进ipa包中时，就不注册，打进来就自动注册。

这个单例不需要关心这个模块或者这个文件是否打包时打进来。一切希望就是子模块或者文件打进来时，由打进来的类负责执行这些注册动作，单例类中不需要更改任何代码。

该问题的本质是: 如何在模块(比如一个framework)、子模块(可以认为一个framework中的一些文件组成的一个单元，pod库中在podspec中可以定义子模块)或者一个文件，一个类，在以上这些东西中如何在ipa中打进来他们时能够自动执行一些方法，不打进来时就不自动这些方法。

## 可行性分析

在Swift中，要想类初始化的时候执行代码， 首先想到的就是静态变量。但是很遗憾，静态变量是懒加载的，并不会在类加载时执行。

于是想到了OC 类的load方法。load方法在main函数之前执行，比Appdelegate方法早很多，用来注册一些全局路由的跳转非常理想。

## 实现

OC的load方法中，对于单例类进行一些操作。App启动后，各模块之间的跳转，可以通过单例类中注册的路由进行匹配和分发，如使用三方框架**[URLNavigator](https://github.com/devxoul/URLNavigator)**，根据传入的url找到相关的匹配的处理类。

做了一个demo，模拟这种场景，并没有通过URLNavigator来实现， 上代码

```swift
//
//  InvokeAPIProtocol.swift
//  Base
//
//  Created by wanggang on 2021/10/30.
//

import Foundation

public protocol RegisterOperationType {
    func sayHello()
}

public struct RegisterOperation: RegisterOperationType {
    public func sayHello() {
        print(name)
    }
    
    public init(name: String) {
        self.name = name
    }
    var name: String
}

public class ModuleRegisterManager {
    public static let shared = ModuleRegisterManager()
    private init() {}
   	private var operationList = [RegisterOperationType]()
    public func addRegister(operation: RegisterOperationType) {
        operationList.append(operation)
        operation.sayHello()
    }
}
```



ModuleRegisterManager模拟路由管理

addRegister模拟路由注册的动作

子模块A的注册

```swift
//
//  SubRegisterA.m
//  LibA
//
//  Created by wanggang on 2021/10/30.
//

#import "SubRegisterA.h"
#import "LibA/LibA-Swift.h"

@implementation SubRegisterA
+ (void)load {
    [ModuleRegister addDirectlyWithString:@"This is SubRegisterA Register Action"];
}
@end
```



子模块B的注册

```swift
//
//  SubRegisterB.m
//  LibA
//
//  Created by wanggang on 2021/10/30.
//

#import "SubRegisterB.h"
#import "LibA/LibA-Swift.h"

@implementation SubRegisterB
+ (void)load {
    [ModuleRegister addDirectlyWithString:@"This is SubRegisterB Register Action"];
}
@end
```

ModuleRegister 就是一个Swift的一个类，用来实现一些OC可以调用的方法，并转换到调用单例的Swift的代码

```swift
@objc open class ModuleRegister: NSObject {    
    @objc open class func addDirectly(string: String) {
        ModuleRegisterManager.shared.addRegister(operation: RegisterOperation.init(name: string))
    }
}
```



运行结果：

```swift
This is SubRegisterB Register Action
This is SubRegisterA Register Action
```



完整代码，在github

https://github.com/gerrywg/ModuleRegister
