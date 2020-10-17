//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
   
   // MARK: - IBOutlets
   @IBOutlet weak var titleLabel: UILabel!
   
   // MARK: - View Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      setupView()
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      setupTitleAnimation()
   }
}

// MARK: - Helper Methods
extension WelcomeViewController {
   private func setupTitleAnimation() {
      titleLabel.text = ""
      
      var charIndex = 0.0
      let titleText = "⚡️FlashChat"
      for letter in titleText {
         Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
            self.titleLabel.text?.append(letter)
         }
         charIndex += 1
      }
   }
   
   private func setupView() {
      titleLabel.text = ""
   }
}
