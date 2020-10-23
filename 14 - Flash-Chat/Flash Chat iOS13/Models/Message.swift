//
//  Message.swift
//  Flash Chat iOS13
//

import Foundation

struct Message {
   let sender: String
   let body: String
   
   init(sender: String, body: String) {
      self.sender = sender
      self.body = body
   }
   
   init?(with firestoreData: [String: Any]) {
      guard let body = firestoreData[K.FStore.bodyField] as? String,
            let sender = firestoreData[K.FStore.senderField] as? String
      else {
         return nil
      }
      
      self.sender = sender
      self.body = body
   }
}
