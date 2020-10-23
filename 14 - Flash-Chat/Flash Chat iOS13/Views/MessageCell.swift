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
   @IBOutlet weak var avatarImageView: UIImageView!
   
   
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
}
