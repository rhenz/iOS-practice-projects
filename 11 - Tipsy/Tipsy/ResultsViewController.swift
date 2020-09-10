//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Lawrence on 9/8/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    // MARK: Properties
    var splitBill: SplitBill?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Helper Methods
    private func setupView() {
        totalLabel.text = String(format: "%.2f", splitBill?.calculateTotalPerPerson() ?? 0.00)
        settingsLabel.text = splitBill?.getSplitMessage() ?? ""
    }
    // MARK: - IBActions
    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
