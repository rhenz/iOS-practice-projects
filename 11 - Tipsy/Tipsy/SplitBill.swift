//
//  SplitBill.swift
//  Tipsy
//
//  Created by Lawrence on 9/8/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct SplitBill {
    var amount: Double
    var numOfPeople: Int
    var selectedTip: TipPercentage
    
    func calculateTotalPerPerson() -> Double {
        var total: Double = 0
        if selectedTip != .zero {
            total = amount + (amount * selectedTip.decimalValue) // add tip percentage to original amount
        } else {
            total += amount
        }
        
        // Split by number of people
        total /= Double(numOfPeople)
        
        return total
    }
    
    // Split between 4 people, with 10% tip
    func getSplitMessage() -> String {
        var message = ""
        if numOfPeople > 1 {
            message = "Split between \(numOfPeople) people, with \(selectedTip.value)% tip."
        } else {
            message = "Total amount for 1 person, with \(selectedTip.value)% tip."
        }
        return message
    }
}
