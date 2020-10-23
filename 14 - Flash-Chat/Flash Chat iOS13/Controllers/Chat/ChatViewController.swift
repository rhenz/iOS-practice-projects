import UIKit

class ChatViewController: UIViewController {
   
   // MARK: - IBOutlets
   @IBOutlet weak var tableView: UITableView!
   @IBOutlet weak var messageTextfield: UITextField!
   
   // MARK: - Properties
   var messages: [Message] = [
      Message(sender: "1@2.com", body: "Hey"),
      Message(sender: "2@2.com", body: "Hey!!!!"),
      Message(sender: "2@2.com", body: "What's up?!")
   ]
   
   // MARK: - View Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      setupView()
      
      // Set tableview delegate & datasource
      tableView.dataSource = self
      tableView.delegate = self
      
      tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
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

// MARK: - Table View Data Source
extension ChatViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return messages.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell
      let message = messages[indexPath.row]
      cell.messageLabel.text = message.body
      
      return cell
   }
}

// MARK: - Table View Delegate
extension ChatViewController: UITableViewDelegate {
   
}
