//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Lawrence on 8/28/20.
//

import UIKit

class ResultViewController: UIViewController {
   // MARK: - IBActions
   
   // MARK: - Properties
   private let resultView = ResultView()
   private var bmiCalculator: BMICalculator!
   
   // MARK: - Init
   convenience init(bmiCalculator: BMICalculator) {
      self.init()
      self.bmiCalculator = bmiCalculator
   }
   
   // MARK: - View Life Cycle
   
   override func loadView() {
      self.view = self.resultView
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupView()
   }
   
   // MARK: - Helper Methods
   private func setupView() {
      self.resultView.bmiLabel.text = self.bmiCalculator.getBMIString()
      self.resultView.suggestionLabel.text = self.bmiCalculator.getSuggestion()
      self.resultView.backgroundColor = self.bmiCalculator.getColor()
      
      // Setup Result View Delegate
      self.resultView.delegate = self
   }
}


// MARK: - Result View Delegate
extension ResultViewController: ResultViewDelegate {
   func didTapRecalculate() {
      DispatchQueue.main.async { self.dismiss(animated: true, completion: nil) }
//      self.dismiss(animated: true, completion: nil)
   }
}
