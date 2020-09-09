//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    
    // MARK: -
    var storyBrain = StoryBrain()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial story
        self.updateUI()
    }

    // MARK: - Helper Methods
    private func updateUI() {
        self.storyLabel.text = storyBrain.getStory()
        self.choice1Button.setTitle(storyBrain.getChoice1(), for: .normal)
        self.choice2Button.setTitle(storyBrain.getChoice2(), for: .normal)
    }
    
    // MARK: - IBActions
    @IBAction func choiceButtonPressed(_ sender: UIButton) {
        guard let storyText = sender.titleLabel?.text else {
            fatalError("Story not found")
        }
        
        self.storyBrain.nextStory(userChoice: storyText)
        self.updateUI()
    }
}
