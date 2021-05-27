//
//  Calculator.swift
//  Calculator
//
//  Created by JLCS on 5/24/21.
//

import Foundation

struct Calculator {
    // MARK: - Properties
    private var number: Double?
    
    private var intermediateCalculation: (n1: Double, operation: CalculatorOperation)?
    
    // MARK: - Helpers
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    // MARK: - Public Functions
    mutating public func operationPressed(_ operation: CalculatorOperation) -> Double? {
        
        guard let n = number else { return nil }

        var value: Double? = nil

        switch operation {
        case .ac:
            value = 0
        case .negativePositive:
            value = n * -1
        case .percent:
            value = n / 100
        case .addition:
            intermediateCalculation = (n1: n, operation: operation)
            value = n
        case .subtraction:
            intermediateCalculation = (n1: n, operation: operation)
            value = n
        case .multiplication:
            intermediateCalculation = (n1: n, operation: operation)
            value = n
        case .division:
            intermediateCalculation = (n1: n, operation: operation)
            value = n
        case .compute:
            value = performTwoNumCalculation(n2: n)
        }
        
        return value
    }
    
    // MARK: - Private Helpers
    private func performTwoNumCalculation(n2: Double) -> Double? {
        
        guard let operation = intermediateCalculation?.operation,
              let n1 = intermediateCalculation?.n1
        else {
            return nil
        }
        
        var value: Double?
        
        switch operation {
        
        case .addition:
            value  = n1 + n2
        case .subtraction:
            value = n1 - n2
        case .multiplication:
            value = n1 * n2
        case .division:
            value = n1 / n2
            
        default: break
        }
        
        return value
    }
}
