import UIKit

fileprivate enum Segue {
   static let toChatViewController = "RegisterToChatSegue"
}

class RegisterViewController: UIViewController {
   // MARK: - IBOutlets
   @IBOutlet weak var emailTextfield: UITextField!
   @IBOutlet weak var passwordTextfield: UITextField!
   
   // MARK: - IBActions
   @IBAction func registerPressed(_ sender: UIButton) {
      guard let email = emailTextfield.text,
            let password = passwordTextfield.text
      else {
         return
      }
      
      let registerService = RegisterService(email: email, password: password)
      registerService.createUser { [weak self] (result) in
         switch result {
         case.success:
            self?.performSegue(withIdentifier: Segue.toChatViewController, sender: self)
         case .failure(let error):
            self?.showErrorAlert(with: error)
         }
      }
   }
}
