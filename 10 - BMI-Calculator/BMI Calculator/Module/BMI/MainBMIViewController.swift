//
//  MainBMIViewController.swift
//  BMI Calculator
//
//  Created by Lawrence on 8/25/20.

import UIKit

class MainBMIViewController: UIViewController {
   // MARK: - IBOutlets
   @IBOutlet weak var heightLabel: UILabel!
   @IBOutlet weak var weightLabel: UILabel!
   @IBOutlet weak var heightSlider: UISlider!
   @IBOutlet weak var weightSlider: UISlider!
   @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
   
   // MARK: - Properties
   
   // MARK: - View Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
   }
   
   // MARK: - IBActions
   @IBAction func heightSliderChanged(_ sender: UISlider) {
      heightLabel.text = UnitFormatter.height(value: sender.value)
   }
   
   @IBAction func weightSliderChanged(_ sender: UISlider) {
      weightLabel.text = UnitFormatter.weight(value: sender.value)
   }
   
   @IBAction func calculateButtonPressed(_ sender: UIButton) {
      let height = heightSlider.value
      let weight = weightSlider.value
      let gender: Gender = genderSegmentedControl.selectedSegmentIndex == 0 ? .male : .female
      
      let bmi = BMICalculator(height: height, weight: weight, gender: gender)
      let resultVC = ResultViewController(bmiCalculator: bmi)
      self.present(resultVC, animated: true, completion: nil)
   }
   
   @IBAction func genderChanged(_ sender: UISegmentedControl) {
      print("Did Change Gender: \(sender.selectedSegmentIndex)")
   }
}
