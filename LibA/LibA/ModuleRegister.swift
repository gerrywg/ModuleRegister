//
//  ModuleRegister.swift
//  LibA
//
//  Created by wanggang on 2021/10/30.
//

import Foundation
import UIKit
import Base


struct Person {
    var name: String
    var age: Int
    
    func sayHello() {
        print("name: \(name), age: \(age)")
    }
}

@objc open class ModuleRegister: NSObject, InvokeAPIProtocol {
    public static func register() {
        actionList.forEach { block in
            print("\(block())")
        }
    }
    
    static var actionList = [() -> String]()

    @objc open class func add(_ action: @escaping () -> String) {
        actionList.append(action)
    }
    
    @objc open class func addDirectly(string: String) {
        ModuleRegisterManager.shared.addRegister(operation: RegisterOperation.init(name: string))
    }
}
