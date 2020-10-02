//
//  ExchangeRateData.swift
//  ByteCoin
//
//  Created by Lawrence on 10/2/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

//{
//  "time": "2017-08-09T14:31:18.3150000Z",
//  "asset_id_base": "BTC",
//  "asset_id_quote": "USD",
//  "rate": 3260.3514321215056208129867667
//}

struct ExchangeRateData: Decodable {
   let assetIdBase: String
   let assetIdQuote: String
   let rate: Double
   
   enum CodingKeys: String, CodingKey {
      case assetIdBase = "asset_id_base"
      case assetIdQuote = "asset_id_quote"
      case rate
   }
}
