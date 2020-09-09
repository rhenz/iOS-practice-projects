//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by John Lawrence Salvador on 12/28/19.
//  Copyright © 2019 John Lawrence Salvador. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var dice1ImageView: UIImageView!
    @IBOutlet weak var dice2ImageView: UIImageView!
    
    // MARK: - Properties
    let diceFaceImages = [#imageLiteral(resourceName: "Dice1"), #imageLiteral(resourceName: "Dice2"), #imageLiteral(resourceName: "Dice3"), #imageLiteral(resourceName: "Dice4"), #imageLiteral(resourceName: "Dice5"), #imageLiteral(resourceName: "Dice6")]
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Private Helpers
    // Solution 1
    private func generateRandomNumber() -> Int {
        // Generate random number between 1 and 6
        return Int.random(in: 1...6)
    }
    
    private func rollDice() {
        // Solution 1
        /*
        let firstNumber = generateRandomNumber()
        let secondNumber = generateRandomNumber()
        
        // Change image views
        DispatchQueue.main.async {
            self.dice1ImageView.image = UIImage(named: "Dice\(firstNumber)")
            self.dice2ImageView.image = UIImage(named: "Dice\(secondNumber)")

        }*/
        
        // Solution 2
        self.dice1ImageView.image = diceFaceImages.randomElement()
        self.dice2ImageView.image = diceFaceImages.randomElement()
    }

    // MARK: - IBActions
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        rollDice()
    }
}

