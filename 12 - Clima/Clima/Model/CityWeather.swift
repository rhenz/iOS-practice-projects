//
//  CityWeather.swift
//  Clima
//
//  Created by Lawrence on 9/15/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct CityWeather: Decodable {
   let weather: [Weather]
   let main: Main
   let name: String
   
   // MARK: - Helper Methods
   func getWeatherConditionImageName() -> String {
      switch weather[0].id {
      case 200...202: // Thunderstorm with Rain
         return "cloud.bolt.rain"
      case 210...221: // Just Thunderstorm
         return "cloud.bolt"
      case 230...232: // Thunderstorm with Rain/Drizzle
         return "cloud.bolt.rain"
      case 300...321: // Drizzle
         return "cloud.drizzle"
      case 500...501: // Light - Moderate Rain
         return "cloud.rain"
      case 502...531: // Heavy Rain
         return "cloud.heavyrain"
      case 600...622: // Snow
         return "cloud.snow"
      case 711: // Smoke
         return "smoke"
      case 721: // Haze
         return "sun.haze"
      case 731, 761: // Dust
         return "sun.dust"
      case 781: // Tornado
         return "tornado"
      case 801...804: // Clouds
         return "cloud"
      default:
         return "cloud"
      }
   }
}

struct Weather: Decodable {
   let id: Int
   let main: String
   let description: String
   let icon: String
}

struct Main: Decodable {
   let temp: Float
   let feelsLike: Float
   let tempMin: Float
   let tempMax: Float
   let pressure: Int
   let humidity: Int
   
   enum CodingKeys: String, CodingKey {
      case temp
      case feelsLike = "feels_like"
      case tempMin = "temp_min"
      case tempMax = "temp_max"
      case pressure
      case humidity
   }
}
