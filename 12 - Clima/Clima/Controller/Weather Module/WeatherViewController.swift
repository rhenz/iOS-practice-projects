//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
   
   // MARK: - Properties
   @IBOutlet weak var conditionImageView: UIImageView!
   @IBOutlet weak var temperatureLabel: UILabel!
   @IBOutlet weak var cityLabel: UILabel!
   @IBOutlet weak var searchTextField: UITextField!
   
   let weatherLoader = WeatherLoader()
   
   // MARK: - View Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      searchTextField.delegate = self
   }
   
   
   // MARK: - Helper Methods
   private func fetchWeather(for city: String) {
      weatherLoader.fetchWeather(cityName: city, completion: { [weak self] result in
         guard let weakSelf = self else { return }
         switch result {
         case .success(let cityWeather):
            // Update UI
            DispatchQueue.main.async {
               weakSelf.updateUI(with: cityWeather)
            }
         case .failure(let error):
            print("ERROR: \(error.localizedDescription)")
         }
      })
   }
   
   private func updateUI(with weather: CityWeather) {
      self.cityLabel.text = searchTextField.text ?? ""
      self.temperatureLabel.text = "\(weather.main.temp)"
      self.conditionImageView.image = UIImage(systemName: weather.getWeatherConditionImageName())
   }
   
   // MARK: - IBActions
   @IBAction func searchButtonPressed(_ sender: UIButton) {
      searchTextField.endEditing(true)
      
      if let city = searchTextField.text, city != "" {
         fetchWeather(for: city)
      }
   }
}

// MARK: - Touch
extension WeatherViewController {
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesBegan(touches, with: event)
      searchTextField.endEditing(true)
   }
}


// MARK: - TextField Delegate
extension WeatherViewController: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      if textField == searchTextField, let text = textField.text, text != "" {
         // Handle text here
         fetchWeather(for: text)
         textField.endEditing(true)
      }
      return true
   }
   
   
}
