//
//  RegisterService.swift
//  Flash Chat iOS13
//
//  Created by Lawrence on 10/17/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation
import FirebaseAuth

enum RegistrationResult {
   case success
   case failure(error: String)
}

class RegisterService {
   // MARK: - Properties
   private let auth = Auth.auth()
   private(set) var email: String
   private(set) var password: String
   
   // MARK: - Init
   init(email: String, password: String) {
      self.email = email
      self.password = password
   }
   
   // MARK: - Helper Methods
   public func createUser(completion: @escaping (RegistrationResult) -> Void) {
      self.auth.createUser(withEmail: self.email, password: self.password) { (result, error) in
         if let error = error {
            completion(.failure(error: error.localizedDescription))
            return
         }
         completion(.success)
      }
   }
   
}
