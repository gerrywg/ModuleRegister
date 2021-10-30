//
//  ModuleRegister.swift
//  LibA
//
//  Created by wanggang on 2021/10/30.
//

import Foundation
import UIKit
import Base


@objc open class ModuleRegister: NSObject {
    @objc open class func addDirectly(string: String) {
        ModuleRegisterManager.shared.addRegister(operation: RegisterOperation.init(name: string))
    }
}
