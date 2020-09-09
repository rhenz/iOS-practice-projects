//
//  ResultView.swift
//  BMI Calculator
//
//  Created by Lawrence on 8/28/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

protocol ResultViewDelegate: class {
   func didTapRecalculate()
}

class ResultView: UIView {
   
   // Background (UIImage - full screen)
   lazy var backgroundImageView: UIImageView = {
      let iv = UIImageView(image: #imageLiteral(resourceName: "result_background"))
      iv.contentMode = .scaleAspectFill
      iv.translatesAutoresizingMaskIntoConstraints = false
      return iv
   }()
   
   // "Your Result" (UILabel)
   lazy var titleLabel: UILabel = {
      var label = UILabel()
      label.text = "YOUR RESULT"
      label.textColor = .white
      label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   // BMI (UILabel)
   lazy var bmiLabel: UILabel = {
      var label = UILabel()
      label.text = "<BMI>"
      label.textColor = .white
      label.textAlignment = .center
      label.font = UIFont.systemFont(ofSize: 80, weight: .bold)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   // Label for suggestions (UILabel)
   lazy var suggestionLabel: UILabel = {
      var label = UILabel()
      label.text = "<SUGGESTION>"
      label.numberOfLines = 0
      label.textAlignment = .center
      label.textColor = .white
      label.font = UIFont.systemFont(ofSize: 20, weight: .light)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()

   // Stack view for the labels above
   lazy var labelHStack: UIStackView = {
      var hstack = UIStackView(arrangedSubviews: [titleLabel, bmiLabel, suggestionLabel])
      hstack.axis = .vertical
      hstack.spacing = 10
      hstack.translatesAutoresizingMaskIntoConstraints = false
      hstack.alignment = .center
      return hstack
   }()
   
   // UIButton at the bottom
   lazy var recalculateButton: UIButton = {
      var button = UIButton()
      button.setTitle("RECALCULATE", for: .normal)
      button.setTitleColor(#colorLiteral(red: 0.4549019608, green: 0.4470588235, blue: 0.8235294118, alpha: 1), for: .normal)
      button.backgroundColor = .white
      button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .light)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
   }()
   
   weak var delegate: ResultViewDelegate?
   
   // MARK: - Init
   override init(frame: CGRect) {
      super.init(frame: frame)
      commonInit()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   private func commonInit() {
      self.backgroundColor = #colorLiteral(red: 0.7000236355, green: 0.7901783349, blue: 1, alpha: 1)
      self.addSubview(backgroundImageView)
      self.addSubview(labelHStack)
      self.addSubview(recalculateButton)
      
      // Add target
      self.recalculateButton.addTarget(self, action: #selector(didTapRecalculateButton(_:)), for: .touchUpInside)
      
      // Setup Constraints
      NSLayoutConstraint.activate([
         self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
         self.backgroundImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
         self.backgroundImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
         self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         
         self.labelHStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
         self.labelHStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         self.labelHStack.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 0),
         self.labelHStack.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: 0),
         
         self.recalculateButton.heightAnchor.constraint(equalToConstant: 50),
         self.recalculateButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
         self.recalculateButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 10),
         self.recalculateButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -10)
      ])
   }
   
   // MARK: - Helper Method
   @objc private func didTapRecalculateButton(_ sender: UIButton) {
      self.delegate?.didTapRecalculate()
   }
}
