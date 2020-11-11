import UIKit

class WelcomeViewController: UIViewController {
   
   // MARK: - IBOutlets
   @IBOutlet weak var titleLabel: UILabel!
   
   // MARK: - View Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.navigationController?.isNavigationBarHidden = true
      titleLabel.text = ""
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      self.navigationController?.isNavigationBarHidden = false
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      setupTitleAnimation()
   }
}

// MARK: - Helper Methods
extension WelcomeViewController {
   private func setupTitleAnimation() {
      var charIndex = 0.0
      let titleText = K.appName
      for letter in titleText {
         Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
            self.titleLabel.text?.append(letter)
         }
         charIndex += 1
      }
   }
}
