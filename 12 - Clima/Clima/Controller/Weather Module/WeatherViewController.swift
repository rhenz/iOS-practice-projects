//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
   
   // MARK: - Properties
   @IBOutlet weak var conditionImageView: UIImageView!
   @IBOutlet weak var temperatureLabel: UILabel!
   @IBOutlet weak var cityLabel: UILabel!
   @IBOutlet weak var searchTextField: UITextField!
   
   let weatherLoader = WeatherLoader()
   let locationManager = CLLocationManager()
   
   // MARK: - View Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Set textfield delegate
      searchTextField.delegate = self
      
      // Ask for location permission
      locationManager.delegate = self
      locationManager.requestWhenInUseAuthorization()
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      locationManager.requestLocation()
   }
   
   // MARK: - Helper Methods
   private func fetchWeather(fetchType: FetchWeatherRequestType) {
      weatherLoader.fetchWeather(fetchType: fetchType) { [weak self] result in
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
      }
   }
   
   private func updateUI(with weather: CityWeather) {
      self.cityLabel.text = weather.name
      self.temperatureLabel.text = "\(weather.main.temp)"
      self.conditionImageView.image = UIImage(systemName: weather.getWeatherConditionImageName())
   }
   
   // MARK: - IBActions
   @IBAction func searchButtonPressed(_ sender: UIButton) {
      searchTextField.endEditing(true)
      
      if let city = searchTextField.text, city != "" {
         fetchWeather(fetchType: .cityName(city: city))
      }
   }
   
   @IBAction func getLocationButtonPressed(_ sender: UIButton) {
      locationManager.requestLocation()
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
         fetchWeather(fetchType: .cityName(city: text))
         textField.endEditing(true)
      }
      return true
   }
}

// MARK: - Location Manager
extension WeatherViewController: CLLocationManagerDelegate {
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      if let location = locations.last {
         locationManager.stopUpdatingLocation()
         let latitude = location.coordinate.latitude
         let longitude = location.coordinate.longitude
         fetchWeather(fetchType: .latLong(lat: latitude, long: longitude))
      }
   }
   
   func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print("Failed Getting Location: \(error.localizedDescription)")
   }
}
