//
//  TFButton.swift
//  Quizzler
//
//  Created by John Lawrence Salvador on 7/7/20.
//  Copyright © 2020 JLCS Inc. All rights reserved.
//

import UIKit
import QuartzCore

// True/False Button
@IBDesignable final class TFButton: UIButton {
    
    // Allows developer to edit what colors are show in each state
    @IBInspectable var borderColorSelected: UIColor = UIColor.purple
    @IBInspectable var borderColorDeselected: UIColor = UIColor.gray
    
    // Width of Dash/Solid Border
    @IBInspectable var borderWidth: CGFloat = 3
    
    // Radius of corners of the button
    @IBInspectable var cornerRadius: CGFloat = 10
    
    // The text color that's shown in each state
    @IBInspectable var textColorDeselected: UIColor = UIColor.white
    @IBInspectable var textColorSelected: UIColor = UIColor.white
    
    // Button's value true/false
    @IBInspectable var valueIndex: Int = 0
    
    // Feedback colors for correct&incorrect answers
    @IBInspectable var correctAnswerBorderColor: UIColor = UIColor.green
    @IBInspectable var incorrectAnswerBorderColor: UIColor = UIColor.red

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // Required method to present changes in IB/Storyboard
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    
    // MARK: - Helper Methods
    func setupView() {
        // Multiple touch disable
        self.isMultipleTouchEnabled = false
        
        // Set border width
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColorDeselected.cgColor
        
        // Set corner radius
        self.layer.cornerRadius = self.cornerRadius
        self.layer.masksToBounds = true
        
        self.setTitleColor(self.textColorSelected, for: .highlighted)
        self.setTitleColor(self.textColorDeselected, for: .normal)
        
        
        // Respond to touch events by user
        self.addTarget(self, action: #selector(onPressHold), for: .touchDown)
        self.addTarget(self, action: #selector(touchCancel), for: [.touchCancel, .touchUpOutside, .touchDragExit, .touchDragOutside, .touchUpInside])
    }
    
    @objc private func onPressHold() {
        self.layer.borderColor = self.borderColorSelected.cgColor
    }
    
    @objc private func touchCancel() {
        self.layer.borderColor = self.borderColorDeselected.cgColor
    }
    
    // Change border colors depending if the answer is correct or wrong
    func updateBorderColorOnAnswer(isCorrect: Bool, didFinishFeedback: @escaping () -> () ) {
        let color = isCorrect ? self.correctAnswerBorderColor : self.incorrectAnswerBorderColor
        self.layer.borderColor = color.cgColor
        
        // Add delay effect for a sense of feedback
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.layer.borderColor = self.borderColorDeselected.cgColor
            didFinishFeedback()
        }
    }
    
    func updateButtonTitle(withTitle title: String) {
        self.setTitle(title, for: .normal)
    }
    
}
