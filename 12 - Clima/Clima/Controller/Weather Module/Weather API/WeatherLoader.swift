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

enum FetchWeatherRequestType {
   case cityName(city: String)
   case latLong(lat: Double, long: Double)
}

struct WeatherLoader {
   let currentWeatherURL = "https://api.openweathermap.org/data/2.5/weather"
   let appId = "0986e1cead171e460c1cb63e7ea4286f"
   
   public func fetchWeather(fetchType: FetchWeatherRequestType, completion: @escaping (WeatherResult) -> Void) {
      var urlString = currentWeatherURL
      switch fetchType {
      case .cityName(let city):
         urlString += "?q=\(city)&appid=\(appId)&units=metric"
      case .latLong(let latitude, let longitude):
         // api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
         urlString += "?lat=\(latitude)&lon=\(longitude)&appid=\(appId)&units=metric"
      }
      
      let url = URL(string: urlString)!
      request(url: url, completion: completion)
   }
   
   private func request(url: URL, completion: @escaping (WeatherResult) -> Void) {
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
