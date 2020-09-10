//
//  BMICalculator.swift
//  BMI Calculator
//
//  Created by Lawrence on 8/25/20.
//

import Foundation
import UIKit

enum Gender {
   case male
   case female
}

enum BMI {
   case underweight
   case normal
   case marginallyOverweight
   case overweight
   case obese
   case areYouHuman
   
   var bmiSuggestion: String {
      switch self {
      case .underweight:
         return "You should eat more!"
      case .normal:
         return "Maintain your diet!"
      case .marginallyOverweight:
         return "Careful! You're almost obese!"
      case .overweight:
         return "Watch your diet!"
      case .obese:
         return "You should exercise already and watch your diet fatso!"
      case .areYouHuman:
         return "Are you sure you're a human?"
      }
   }
   
   var color: UIColor {
      switch self {
      case .underweight:
         return #colorLiteral(red: 0.4098633528, green: 0.8456347585, blue: 1, alpha: 1)
      case .normal:
         return #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
      case .marginallyOverweight:
         return #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
      case .overweight:
         return #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
      case .obese:
         return #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
      case .areYouHuman:
         return #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
      }
   }
   
   static func getBMIDefinition(for gender: Gender, bmiValue: Float) -> BMI {
      switch gender {
      case .male:
         switch bmiValue {
         case 18.5..<20.7:
            return .underweight
         case 20.7..<26.4:
            return .normal
         case 26.4..<27.8:
            return .marginallyOverweight
         case 27.8..<31.1:
            return .overweight
         case 31.1...:
            return .obese
         default:
            return .areYouHuman
         }
      case .female:
         switch bmiValue {
         case 18.5..<19.1:
            return .underweight
         case 19.1..<25.8:
            return .normal
         case 25.8..<27.3:
            return .marginallyOverweight
         case 27.3..<32.3:
            return .overweight
         case 32.3...:
            return .obese
         default:
            return .areYouHuman
         }
      }
   }
}

struct BMICalculator {
   // MARK: - Properties
   private(set) var height: Float
   private(set) var weight: Float
   private(set) var gender: Gender
   
   
   // MARK: - Helper Methods
   func getBMIString() -> String {
      let bmi = weight / powf(height, 2)
      return String(format: "%.1f", bmi)
   }
   
   func getBMI() -> Float {
      let bmi = weight / powf(height, 2)
      let divisor = Float(pow(10.0, Double(1)))
      return roundf(bmi * divisor) / divisor
   }
   
   func getSuggestion() -> String {
      return getBMICategory().bmiSuggestion
   }
   
   func getColor() -> UIColor {
      return getBMICategory().color
   }
   
   private func getBMICategory() -> BMI {
      let bmi = self.getBMI()
      return BMI.getBMIDefinition(for: self.gender, bmiValue: bmi)
   }
}
