//
//  CalculatorViewController.swift
//  Tipsy

import UIKit

enum TipPercentage: Int, CaseIterable {
    case zero = 0
    case ten = 10
    case twenty = 20
    
    var value: Int {
        return self.rawValue
    }
    
    var decimalValue: Double {
        return Double(self.rawValue) / 100.0
    }
}

class CalculatorViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    // MARK: - Properties
    private var selectedTip: TipPercentage = .ten
    private var numOfPeople: UInt = 1
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
    }
    
    
    // MARK: IBActions
    @IBAction func tipChanged(_ sender: UIButton) {
        // Dismiss keyboard
        billTextField.endEditing(true)
        
        guard let selectedTip = TipPercentage(rawValue: sender.tag) else {
            print("Selected Tip is Unknown")
            return
        }
        
        // Set selected tip
        self.selectedTip = selectedTip
        
        // Reset all button
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        // Set current selected button
        sender.isSelected = true
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        // Dismiss keyboard
        billTextField.endEditing(true)
        
        numOfPeople = UInt(sender.value)
        splitNumberLabel.text = "\(numOfPeople)"
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        // Dismiss keyboard
        billTextField.endEditing(true)
        
        guard let amountStr = billTextField.text,
            let amount = Double(amountStr)
            else {
                showNoInputAmountAlert()
                return
        }
        
        let splitBill = SplitBill(amount: amount, numOfPeople: Int(numOfPeople), selectedTip: selectedTip)
        
        self.performSegue(withIdentifier: "resultsViewControllerSegue", sender: splitBill)
    }
    
    private func showNoInputAmountAlert() {
        let ac = UIAlertController(title: "Notice", message: "Enter valid amount!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? ResultsViewController {
            destVC.splitBill = sender as? SplitBill
        }
    }
}

