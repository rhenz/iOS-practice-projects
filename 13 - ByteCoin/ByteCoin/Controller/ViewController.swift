//
//  ViewController.swift
//  ByteCoin
//
import UIKit

class ViewController: UIViewController {
   
   // MARK: - IBOutlets
   @IBOutlet weak var currencyLabel: UILabel!
   @IBOutlet weak var bitcoinLabel: UILabel!
   @IBOutlet weak var currencyPicker: UIPickerView!
   
   // MARK: - Properties
   let coinManager = CoinManager()
   
   // MARK: - View Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      
      currencyPicker.dataSource = self
      currencyPicker.delegate = self
   }
}
// MARK: - Helper Methods
extension ViewController {
   private func fetchExchangeRate(for currency: String) {
      DispatchQueue.global().async {
         self.coinManager.getCoinPrice(for: currency) { [weak self] (result) in
            switch result {
            case .success(let data):
               DispatchQueue.main.async {
                  // Update UI
                  self?.bitcoinLabel.text = String(format: "%.2f", data.rate)
                  self?.currencyLabel.text = data.assetIdQuote
               }
            case .failure(let error):
               DispatchQueue.main.async {
                  self?.showErrorAlert(message: error.localizedDescription)
               }
            }
         }
      }
   }
   
   private func showErrorAlert(message: String) {
      let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
      self.present(ac, animated: true, completion: nil)
   }
}

// MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return coinManager.currencyArray.count
   }
}

// MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return coinManager.currencyArray[row]
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      let selected = coinManager.currencyArray[row]
      guard selected != "-" else { return }
      self.fetchExchangeRate(for: selected)
   }
}

