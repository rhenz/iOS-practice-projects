import UIKit

extension UIViewController {
   
   func showErrorAlert(with message: String) {
      let ac = createAlertController(with: "Error", message: message)
      self.present(ac, animated: true, completion: nil)
   }
   
   func showNoticeAlert(with message: String) {
      let ac = createAlertController(with: "Notice", message: message)
      self.present(ac, animated: true, completion: nil)
   }
   
   func showAlert(with title: String, message: String) {
      let ac = createAlertController(with: title, message: message)
      self.present(ac, animated: true, completion: nil)
   }
   
   private func createAlertController(with title: String, message: String) -> UIAlertController {
      let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
      ac.addAction(okAction)
      return ac
   }
}
