//
//  UIViewController+Extension.swift
//  CarTender
//
//  Created by R@NJ!T on 10/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//
import Foundation
extension Optional {
    
    var boolValue: Bool {
        switch self {
        case .some(let value):
            return String(describing: value) != "0"
        case _:
            return false
        }
    }
    
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
    func aInt32OrEmpty(defaultValue:Int32 = 0) -> Int32 {
        switch self {
        case .some(let value):
            return Int32(String(describing: value)) ?? defaultValue
        case _:
            return defaultValue
        }
    }
    func aInt16OrEmpty(defaultValue:Int16 = 0) -> Int16 {
        switch self {
        case .some(let value):
            return Int16(String(describing: value)) ?? defaultValue
        case _:
            return defaultValue
        }
    }
    
    func aDoubleOrEmpty(defaultValue:Double = 0.0) -> Double {
        switch self {
        case .some(let value):
            return Double(String(describing: value)) ?? defaultValue
        case _:
            return defaultValue
        }
    }
    
    func asStringOrNilText() -> String {
        switch self {
        case .some(let value):
            return String(describing: value)
        case _:
            return "(nil)"
        }
    }
    
    func hasEmpty() -> Bool {
        switch self {
        case .some(let value):
            if (String(describing: value) == "") {
                return true
            }
            return false
        case _:
            return true
        }
    }
        
}
