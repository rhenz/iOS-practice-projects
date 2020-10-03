//
//  CoinManager.swift
//  ByteCoin
//

import Foundation

enum ExchangeRateResult {
   case success(ExchangeRateData)
   case failure(Error)
}

struct CoinManager {
   
   // MARK: - Properties
   let apiKey = "DF929C77-8F34-41F6-A799-C86F208CDAE2"
   private let scheme = "https"
   private let host = "rest.coinapi.io"
   private let path = "/v1/exchangerate/BTC"
   
   let currencyArray = ["-","AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
   
   typealias ExchangeRateResponse = (ExchangeRateResult) -> Void
   
   // MARK: - Helper Methods
   func getCoinPrice(for currency: String, completion: @escaping ExchangeRateResponse) {
//      https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=DF929C77-8F34-41F6-A799-C86F208CDAE2
      // Format URL
      let queryItems = [
         URLQueryItem(name: "apikey", value: apiKey)
      ]
      let url = getUrl(currencyPath: currency, queryItems: queryItems)
      
      getExchangeRate(for: url, completion: completion)
   }
   
   private func getExchangeRate(for url: URL, completion: @escaping ExchangeRateResponse) {
      URLSession.shared.dataTask(with: url) { (data, response, error) in
         if let error = error { completion(.failure(error)) }
         
         // Parse data
         do {
            let exchangeRateData = try JSONDecoder().decode(ExchangeRateData.self, from: data!)
            completion(.success(exchangeRateData))
         } catch(let error) {
            completion(.failure(error))
         }
      }.resume()
   }
   
   private func getUrl(currencyPath: String, queryItems: [URLQueryItem]) -> URL {
      var urlComponents = URLComponents()
      urlComponents.scheme = scheme
      urlComponents.host = host
      urlComponents.path = path + "/" + currencyPath
      urlComponents.queryItems = queryItems
      
      guard let url = urlComponents.url else {
         fatalError("Could not create URL")
      }
      
      return url
   }
}
