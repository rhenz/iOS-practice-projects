//
//  WeatherLoader.swift
//  Clima
//
//  Created by Lawrence on 9/12/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

enum WeatherResult {
   case success(CityWeather)
   case failure(Error)
}

struct WeatherLoader {
   let currentWeatherURL = "https://api.openweathermap.org/data/2.5/weather"
   let appId = "0986e1cead171e460c1cb63e7ea4286f"
   
   func fetchWeather(cityName: String, completion: @escaping (WeatherResult) -> Void) {
      // Set URL
      let urlString = "\(currentWeatherURL)?q=\(cityName)&appid=\(appId)&units=metric"
      let url = URL(string: urlString)!
      
      // Create URLSession
      URLSession.shared.dataTask(with: url) { (data, response, error) in
         if error != nil {
            completion(.failure(error!))
         }
         
         // Parse data
         do {
            let cityWeather = try JSONDecoder().decode(CityWeather.self, from: data!)
            completion(.success(cityWeather))
         } catch(let err) {
            completion(.failure(err))
         }
      }.resume()
   }
}
