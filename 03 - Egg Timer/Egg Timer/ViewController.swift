//
//  ViewController.swift
//  Egg Timer
//
//  Created by John Lawrence Salvador on 7/3/20.
//  Copyright © 2020 JLCS Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var progressBarView: UIProgressView!
    
    // MARK: - Properties
    /// Part of  Solution 2
    enum EggHardness: String, CaseIterable {
        case soft = "Soft"
        case medium = "Medium"
        case hard = "Hard"
        
        var cookingTime: Int {
            switch self {
            case .soft:
                return 5
            case .medium:
                return 7
            case .hard:
                return 12
            }
        }
    }
    
    private var timer: Timer?
    private var secondsToBoilEgg = 0
    private var remainingSeconds = 0
    
    private var player: AVAudioPlayer!
   
    // Constants
    /// Part of Solution 1
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Helper Methods
    private func startTimer() {
        // Check if timer is running
        if timer?.isValid ?? false {
            timer?.invalidate()
        }
        
        // Set Timer
        remainingSeconds = secondsToBoilEgg
        
        // Update Progress Bar
        updateProgressBar()
        
        // Set & Start Timer
        remainingSeconds -= 1
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    @objc
    private func countDown() {
        // Update Progress Bar
        updateProgressBar()
        
        // Check if countdown timer reached 0
        if remainingSeconds == 0 {
            // Done!
            self.textLabel.text = "Done!"
            
            // Play Complete Sound
            self.playSound()
            
            // Stop Timer
            timer?.invalidate()
            return
        }
        
//        print("\(remainingSeconds) seconds")
        // Deduct remaining seconds every 1 second
        remainingSeconds -= 1
    }
    
    private func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }
    
    private func updateProgressBar() {
        let progress: Float = Float(self.secondsToBoilEgg - self.remainingSeconds) / Float(self.secondsToBoilEgg)
        DispatchQueue.main.async {
            self.progressBarView.progress = progress
        }
    }

    // MARK: - IBActions
    @IBAction func hardnessButtonPressed(_ sender: UIButton) {
        processEggTimer(sender)
    }
    
    private func showError(_ errorString: String) {
        let ac = UIAlertController(title: "Error", message: errorString, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(okAction)
        present(ac, animated: true)
    }
    
    private func processEggTimer(_ pressedButton: UIButton) {
        
        
        /// Solution 1
        guard let buttonTitle = pressedButton.titleLabel?.text else {
            fatalError("Unexpected Error - No Button Title present")
        }
        
        if let eggTime = eggTimes[buttonTitle] {
//            print("Egg Time: \(eggTime)")
            self.secondsToBoilEgg = eggTime * 60
//            self.secondsToBoilEgg = 5 // For testing
            startTimer()
        }
        
        /// Solution 2
        /*
        guard let buttonTitle = pressedButton.titleLabel?.text else {
            fatalError("Unexpected Error - No Button Title present")
        }
        
        guard let hardness = EggHardness(rawValue: buttonTitle) else {
            fatalError("No Equivalent Hardness Value")
        }
        
        switch hardness {
        case .hard:
            print("HARD: \(hardness.cookingTime)")
        case .medium:
            print("MEDIUM: \(hardness.cookingTime)")
        case .soft:
            print("SOFT: \(hardness.cookingTime)")
        }
        
        print("\(hardness.rawValue) | \(hardness.cookingTime)")
         */
    }
}
