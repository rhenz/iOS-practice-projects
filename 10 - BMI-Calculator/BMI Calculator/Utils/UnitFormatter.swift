//
//  UnitFormatter.swift
//  BMI Calculator
//
//  Created by Lawrence on 8/25/20.
//

import Foundation

public struct UnitFormatter {
   private init() { }
   
   static func height(value: Float) -> String {
      return String(format: "%.2fm", value)
   }
   
   static func weight(value: Float) -> String {
      return String(format: "%.0fKg", value)
   }
}
