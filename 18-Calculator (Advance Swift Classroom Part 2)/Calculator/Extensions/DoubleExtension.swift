//
//  DoubleExtension.swift
//  Calculator
//
//  Created by JLCS on 5/25/21.
//

import Foundation

extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
