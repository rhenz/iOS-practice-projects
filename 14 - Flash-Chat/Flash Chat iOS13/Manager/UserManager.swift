//
//  UserManager.swift
//  Flash Chat iOS13
//
//  Created by Lawrence on 10/23/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation
import FirebaseAuth

class UserManager {
   // MARK: - Singleton
   static let shared = UserManager()
   
   private let auth = Auth.auth()
   
   var email: String? {
      return auth.currentUser?.email
   }
   
   // MARK: - Init
   private init() { }
   
   // MARK: - Helper Methods
   public func logout(completion: @escaping (Error?) -> Void) {
      do {
         try auth.signOut()
         completion(nil)
      } catch let signOutError {
         completion(signOutError)
      }
   }
}
