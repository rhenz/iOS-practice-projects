//
//  CalculatorEnum.swift
//  Calculator
//
//  Created by JLCS on 5/24/21.
//

import Foundation

enum CalculatorOperation {
    case ac
    case negativePositive
    case percent
    case addition
    case subtraction
    case multiplication
    case division
    case compute
    
    init?(_ value: String) {
        switch value.lowercased() {
        case "ac":
            self = .ac
        case "+/-":
            self = .negativePositive
        case "%":
            self = .percent
        case "÷":
            self = .division
        case "×":
            self = .multiplication
        case "-":
            self = .subtraction
        case "+":
            self = .addition
        case "=":
            self = .compute
        default:
            return nil
        }
    }
}
