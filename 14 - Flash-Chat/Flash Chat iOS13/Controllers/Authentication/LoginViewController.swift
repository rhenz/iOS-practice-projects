//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
   // MARK: - IBOutlets
   @IBOutlet weak var emailTextfield: UITextField!
   @IBOutlet weak var passwordTextfield: UITextField!
   
   // MARK: - IBActions
   @IBAction func loginPressed(_ sender: UIButton) {
      guard let email = emailTextfield.text,
            let password = passwordTextfield.text
      else {
         return
      }
      
      let loginService = LoginService(email: email, password: password)
      loginService.loginUser { [weak self] (result) in
         switch result {
         case.success:
            self?.performSegue(withIdentifier: "LoginToChatSegue", sender: self)
         case .failure(let error):
            self?.showErrorAlert(with: error)
         }
      }
   }
   
}
