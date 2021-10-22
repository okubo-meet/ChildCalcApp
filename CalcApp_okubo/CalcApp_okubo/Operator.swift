//
//  Operator.swift
//  CalcApp_okubo
//
//  Created by 大久保徹郎 on 2021/10/15.
//

import Foundation

enum Operator: String {
    case divide = "÷"
    case multiply = "×"
    case subtraction = "-"
    case addition = "+"
    case equal = "="
    
    ///アクティブになっている演算子
    func isActive() -> Bool {
        switch self {
        case .divide:
            return true
        case .multiply:
            return true
        case .subtraction:
            return true
        case .addition:
            return true
        case .equal:
            //"="ボタンは
            return false
        }
    }
}