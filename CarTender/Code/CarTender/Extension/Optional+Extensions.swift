//
//  UIViewController+Extension.swift
//  CarTender
//
//  Created by R@NJ!T on 10/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//
import Foundation
extension Optional {

    func asStringOrEmpty(defaultValue:String = "") -> String {
        switch self {
        case .some(let value):
            return String(describing: value)
        case _:
            return defaultValue
        }
    }

    func aIntOrEmpty(defaultValue:Int = 0) -> Int {
        switch self {
        case .some(let value):
            print(value)
            return Int(String(describing: value)) ?? defaultValue
        case _:
            return defaultValue
        }
    }

}
