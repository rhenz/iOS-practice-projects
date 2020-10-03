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
   case geoLocation(lat: Double, long: Double)
}

struct WeatherLoader {
//   let currentWeatherURL = "https://api.openweathermap.org/data/2.5/weather"
   private let appId = "0986e1cead171e460c1cb63e7ea4286f"
   private let scheme = "https"
   private let host = "api.openweathermap.org"
   private let path = "/data/2.5/weather"
   
   public func fetchWeather(fetchType: FetchWeatherRequestType, completion: @escaping (WeatherResult) -> Void) {
      var urlQueryItems = [URLQueryItem]()
      
      switch fetchType {
      case .cityName(let city):
         urlQueryItems.append(URLQueryItem(name: "q", value: city))
         urlQueryItems.append(URLQueryItem(name: "units", value: "metric"))
         urlQueryItems.append(URLQueryItem(name: "appid", value: appId))
         
      case .geoLocation(let latitude, let longitude):
         urlQueryItems.append(URLQueryItem(name: "lat", value: "\(latitude)"))
         urlQueryItems.append(URLQueryItem(name: "lon", value: "\(longitude)"))
         urlQueryItems.append(URLQueryItem(name: "units", value: "metric"))
         urlQueryItems.append(URLQueryItem(name: "appid", value: appId))
      }
      
      let url = getUrl(queryItems: urlQueryItems)
      
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
   
   private func getUrl(queryItems: [URLQueryItem]) -> URL {
      var urlComponents = URLComponents()
      urlComponents.scheme = scheme
      urlComponents.host = host
      urlComponents.path = path
      urlComponents.queryItems = queryItems
      
      guard let url = urlComponents.url else {
         fatalError("Could not create URL")
      }
      
      return url
   }
}
