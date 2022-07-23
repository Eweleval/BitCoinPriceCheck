//
//  ViewController+Extensions.swift
//  BitCoinPriceCheck
//
//  Created by Decagon on 21/07/2022.
//

import Foundation
import UIKit

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView{
        case currencyPicker:
            return coinManager.currencyArray.count
        case cryptoPicker:
            return coinManager.cryptoArray.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView{
        case currencyPicker:
            return coinManager.currencyArray[row]
        case cryptoPicker:
            return coinManager.cryptoArray[row]
        default:
            return nil 
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView{
        case currencyPicker:
            let selectedCurrency = coinManager.currencyArray[row]
            coinManager.getCoinPrice(for: selectedCurrency)
        case cryptoPicker:
            let selectedCoin = coinManager.cryptoArray[row]
            coinManager.getCoin(coin: selectedCoin)
        default: break
        }
    }
}

// MARK: - CoinManager Delegate
extension ViewController: CoinManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.priceLabel.text = price
            self.currencyLabel.text = currency
        }
    }
}
