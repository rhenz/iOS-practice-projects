import UIKit

class ChatViewController: UIViewController {
   // MARK: - IBOutlets
   @IBOutlet weak var tableView: UITableView!
   @IBOutlet weak var messageTextfield: UITextField!
   
   // MARK: - View Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      setupView()
   }
   
   // MARK: - Helper Methods
   private func setupView() {
      navigationItem.hidesBackButton = true
      title = "⚡️FlashChat"
   }
   
   // MARK: - IBActions
   @IBAction func sendPressed(_ sender: UIButton) {
      
   }
   
   @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
      LoginService.logout { [weak self] (error) in
         if let error = error {
            self?.showErrorAlert(with: error.localizedDescription)
            return
         }
         
         // Back to Login Screen
         self?.navigationController?.popToRootViewController(animated: true)
      }
   }
   
}
