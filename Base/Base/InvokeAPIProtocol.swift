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
