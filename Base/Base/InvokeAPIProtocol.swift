//
//  InvokeAPIProtocol.swift
//  Base
//
//  Created by wanggang on 2021/10/30.
//

import Foundation

public protocol InvokeAPIProtocol {
    static func register()
}

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
    
    public func start() {
        Bundle.allFrameworks.filter({ bundle in
            bundle.bundlePath.hasPrefix("/Applications/") == false
        }).map({ bundle -> String in
            let lastPath = (bundle.bundlePath as NSString).lastPathComponent
            let lastPathName = (lastPath as NSString).deletingPathExtension
            return lastPathName
        }).forEach { str in
            let clsStr = str + ".ModuleRegister"
            if let cls = NSClassFromString(clsStr) as? InvokeAPIProtocol.Type {
                cls.register()
            }
        }
    }
    
    public func addRegister(operation: RegisterOperationType) {
        operationList.append(operation)
        print(operation.sayHello())
    }
}
