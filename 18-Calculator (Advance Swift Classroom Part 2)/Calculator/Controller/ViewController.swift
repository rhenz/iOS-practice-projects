//
//  ViewController.swift
//  Calculator


import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var displayLabel: UILabel!
    
    private let validInput = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "."]
    private var isFinishedTypingNumber: Bool = true
    
    private var displayValue: Double {
        get {
            guard let numValueStr = displayLabel.text,
                  let numValue = Double(numValueStr)
            else {
                fatalError("Cannot convert display label text to a Double")
            }
                  
            return numValue
        }
        
        set {
            displayLabel.text = newValue.clean
        }
        
    }
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    private var calculator = Calculator()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        //What should happen when a non-number button is pressed
        guard let buttonPressedTitle = sender.currentTitle,
            let operationPressed = CalculatorOperation(buttonPressedTitle)
        else {
            print("Invalid calculator operation")
            return
        }
        
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        
        guard let value = calculator.operationPressed(operationPressed) else {
            fatalError("The result of the calculation is nil")
        }
        
        displayValue = value
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        guard let input = sender.currentTitle,
              validInput.contains(input)
        else {
            return
        }
        
        if isFinishedTypingNumber {
            displayLabel.text = input
            isFinishedTypingNumber = false
        } else {
            if input == "." {
                let isInt = floor(displayValue) == displayValue
                if !isInt { return }
            }
            
            displayLabel.text = displayLabel.text! + input
        }
    }
}
