//
//  QuoteTableViewController.swift
//  InspoQuotes
//
//  Created by JLCS on 5/15/21.
//

import UIKit
import StoreKit

class QuoteTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    // this productID can be found in the Apple Developer account
    let productID = "com.jlcs.InspoQuote.PremiumQuotes"
    
    
    var quotesToShow = [
        "Our greatest glory is not in never falling, but in rising every time we fall. — Confucius",
        "All our dreams can come true, if we have the courage to pursue them. – Walt Disney",
        "It does not matter how slowly you go as long as you do not stop. – Confucius",
        "Everything you’ve ever wanted is on the other side of fear. — George Addair",
        "Success is not final, failure is not fatal: it is the courage to continue that counts. – Winston Churchill",
        "Hardships often prepare ordinary people for an extraordinary destiny. – C.S. Lewis"
    ]
    
    let premiumQuotes = [
        "Believe in yourself. You are braver than you think, more talented than you know, and capable of more than you imagine. ― Roy T. Bennett",
        "I learned that courage was not the absence of fear, but the triumph over it. The brave man is not he who does not feel afraid, but he who conquers that fear. – Nelson Mandela",
        "There is only one thing that makes a dream impossible to achieve: the fear of failure. ― Paulo Coelho",
        "It’s not whether you get knocked down. It’s whether you get up. – Vince Lombardi",
        "Your true success in life begins only when you make the commitment to become excellent at what you do. — Brian Tracy",
        "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got to keep going. – Chantal Sutherland"
    ]
    
    var isPurchased: Bool {
        return UserDefaults.standard.bool(forKey: productID)
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView() // Removes empty cell
        
        // Set in-app delegate/observer
        SKPaymentQueue.default().add(self)
        
        // If premium quotes purchased already, show premium quotes.
        if isPurchased {
            showPremiumQuotes()
        }
    }
    
    // MARK: - IBActions
    @IBAction func restoreButtonPressed(_ sender: UIBarButtonItem) {
        restorePurchases()
    }
}


// MARK: - Table view data source
extension QuoteTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return isPurchased ? quotesToShow.count : quotesToShow.count + 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath)

        // Configure the cell...
        if indexPath.row < quotesToShow.count {
            cell.textLabel?.text = quotesToShow[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textColor = .black
            cell.accessoryType = .none
        } else {
            cell.textLabel?.text = "Get More Quotes"
            cell.textLabel?.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            cell.accessoryType = .disclosureIndicator
        }
        

        return cell
    }
}

// MARK: - Table view delegate
extension QuoteTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == quotesToShow.count && !isPurchased {
            buyPremiumQuotes()
        }
    }
}

// MARK: - In-App Purchase Methods
extension QuoteTableViewController {
    private func buyPremiumQuotes() {
        if SKPaymentQueue.canMakePayments() {
            // User can make payments
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
            
        } else {
            // User can't make payments
            print("User can't make payments")
        }
    }
    
    private func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

// MARK: - SKPaymentTransactionObserver
extension QuoteTableViewController: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                print("Purchasing")
                
            case .purchased:
                print("Purchased")
                showPremiumQuotes()
                SKPaymentQueue.default().finishTransaction(transaction)
                
            case .failed:
                if let error = transaction.error {
                    let errorDesc = error.localizedDescription
                    print("Transaction failed due to error: \(errorDesc)")
                }
                
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                print("Transaction Restored")
                showPremiumQuotes()
                SKPaymentQueue.default().finishTransaction(transaction)
                navigationItem.setRightBarButton(nil, animated: true)
                
            case .deferred:
                print("Deferred")
                
            @unknown default:
                fatalError()
            }
        }
    }
    
    func showPremiumQuotes() {
        UserDefaults.standard.set(true, forKey: productID) // Store productID that is bought already
        quotesToShow.append(contentsOf: premiumQuotes)
        self.tableView.reloadData()
    }
}
