//
//  ViewController.swift
//  BitCoinPriceCheck
//
//  Created by Decagon on 21/07/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cryptoPicker: UIPickerView!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!

    var coinManager = CoinManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        coinManager.delegate = self
        cryptoPicker.delegate = self
        cryptoPicker.dataSource = self
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
}

