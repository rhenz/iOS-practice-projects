//
//  ViewController.swift
//  Magic-8-Ball
//
//  Created by John Lawrence Salvador on 1/10/20.
//  Copyright © 2020 John Lawrence Salvador. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    private var ballString = "ball"

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Private Helpers
    private func generateRandomNumbers(range: ClosedRange<Int>) -> Int {
        return Int.random(in: range)
    }
    
    private func askForAnswer() {
        // Generate random number and make it as a String to append later
        let randomNumberStr = String(generateRandomNumbers(range: 1...5))
        let imageName = ballString + randomNumberStr
        
        // Change image
        imageView.image = UIImage(named: imageName)
    }

    // MARK: - IBActions
    @IBAction func askButtonPressed(_ sender: UIButton) {
        askForAnswer()
    }
}

