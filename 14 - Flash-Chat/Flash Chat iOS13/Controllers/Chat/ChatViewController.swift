import UIKit
import FirebaseFirestore

class ChatViewController: UIViewController {
   
   // MARK: - IBOutlets
   @IBOutlet weak var tableView: UITableView!
   @IBOutlet weak var messageTextfield: UITextField!
   
   // MARK: - Properties
   var messages: [Message] = [] {
      didSet {
         DispatchQueue.main.async {
            self.tableView.reloadData()
            let indexPath = IndexPath(row: self.messages.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
         }
      }
   }
   
   private let db = Firestore.firestore()
   
   // MARK: - View Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      setupView()
      
      // Set tableview delegate & datasource
      tableView.dataSource = self
      tableView.delegate = self
      
      tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
      
      loadMessages()
   }
   
   // MARK: - Helper Methods
   private func setupView() {
      navigationItem.hidesBackButton = true
      title = "⚡️FlashChat"
   }
   
   private func loadMessages() {
      db.collection(K.FStore.collectionName)
         .order(by: K.FStore.dateField)
         .addSnapshotListener { (snapshot, error) in
         if let error = error {
            print("Error Retrieving messages: \(error.localizedDescription)")
         } else {
            if let documents = snapshot?.documents {
               let parsedMessages = documents.map { Message(with: $0.data()) }.compactMap{ $0 }
               self.messages.removeAll()
               self.messages = parsedMessages
            }
         }
      }
   }
   
   // MARK: - IBActions
   @IBAction func sendPressed(_ sender: UIButton) {
      guard let sender = UserManager.shared.email, let messageBody = messageTextfield.text else { return }
      
      let message = [K.FStore.senderField: sender, K.FStore.bodyField: messageBody, K.FStore.dateField: Date().timeIntervalSince1970] as [String : Any]
      db.collection(K.FStore.collectionName).addDocument(data: message) { [weak self] (error) in
         guard let error = error else { return }
         print("There was an error in saving data to firestore: \(error.localizedDescription)")
      }
      
      self.messageTextfield.text = ""
   }
   
   @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
      UserManager.shared.logout { [weak self] (error) in
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
      
      let isMyMessage = message.sender == UserManager.shared.email
      cell.updateMessageCell(isMyMessage: isMyMessage, content: message.body)
         
      return cell
   }
}

// MARK: - Table View Delegate
extension ChatViewController: UITableViewDelegate { }
