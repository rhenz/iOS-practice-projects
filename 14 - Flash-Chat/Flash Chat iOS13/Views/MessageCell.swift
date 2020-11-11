//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Lawrence on 10/20/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
   // MARK: - IBOutlets
   @IBOutlet weak var messageBubble: UIView!
   @IBOutlet weak var messageLabel: UILabel!
   @IBOutlet weak var rightImageView: UIImageView!
   @IBOutlet weak var leftImageView: UIImageView!
   
   
   // MARK: - Init
   override func awakeFromNib() {
      super.awakeFromNib()
      setupCell()
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
   
   // MARK: - Helper Methods
   private func setupCell() {
      messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
   }
   
   public func updateMessageCell(isMyMessage: Bool, content: String) {
      if isMyMessage {
         leftImageView.isHidden = true
         rightImageView.isHidden = false
         messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
         messageLabel.textColor = UIColor(named: K.BrandColors.purple)
      } else {
         leftImageView.isHidden = false
         rightImageView.isHidden = true
         messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
         messageLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
      }
      
      messageLabel.text = content
   }
}
