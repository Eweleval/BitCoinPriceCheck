//
//  CoinManager.swift
//  BitCoinPriceCheck
//
//  Created by Decagon on 21/07/2022.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let cryptoArray = ["BTC", "ETC", "ETH", "LTC", "DOGE", "BCH"]

    let apiKey = "YOUR API KEY HERE"
    var urlString = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    
    var delegate: CoinManagerDelegate?

    mutating func getCoin(coin: String) {
        urlString = "https://rest.coinapi.io/v1/exchangerate/\(coin)/"
    }

    func getCoinPrice(for currency: String) {
        let urlString = "\(urlString)\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    print(error!)
                    return
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(CoinData.self, from: safeData)
                        let price = decodedData.rate
                        let priceString = String(format: "%.2f", price)
                        self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                    } catch {
                        self.delegate?.didFailWithError(error: error)
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
}
