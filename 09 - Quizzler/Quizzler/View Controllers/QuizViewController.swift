//
//  QuizViewController.swift
//  Quizzler
//
//  Created by John Lawrence Salvador on 7/8/20.
//  Copyright © 2020 JLCS Inc. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var firstButton: TFButton!
    @IBOutlet weak var secondButton: TFButton!
    @IBOutlet weak var thirdButton: TFButton!
    
    // MARK: - Properties
    var quiz: Quiz!
    
    var questionNumber = 0
    var correctAnswers = 0

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize Quiz
        self.quiz = Quiz(questions: Quiz.multipleChoiceQuestion())
        
        setupView()
    }
    
    // MARK: - Helper Metho
    private func setupView() {
        // Get first question
        self.questionLabel.text = getQuestion()
        
        // Update Initial Buttons
        self.updateButtonTitle()
    }
    
    private func updateButtonTitle() {
        let choices = self.getChoices()
        self.firstButton.updateButtonTitle(withTitle: choices[0])
        self.secondButton.updateButtonTitle(withTitle: choices[1])
        self.thirdButton.updateButtonTitle(withTitle: choices[2])
    }
    
    private func getQuestion() -> String {
        return self.quiz.getQuestion()
    }
    
    private func getChoices() -> [String] {
        return self.quiz.getChoices()
    }
    
    private func disableTFButtonInteractions() {
        self.firstButton.isUserInteractionEnabled = false
        self.secondButton.isUserInteractionEnabled = false
        self.thirdButton.isUserInteractionEnabled = false
    }
    
    private func enableTFButtonInteractions() {
        self.firstButton.isUserInteractionEnabled = true
        self.secondButton.isUserInteractionEnabled = true
        self.thirdButton.isUserInteractionEnabled = true
    }
    
    private func updateLabelForNextQuestion() {
        self.questionLabel.text = self.getQuestion()
        self.updateButtonTitle()
    }
    
    private func updateProgressBar() {
        self.progressBar.progress = self.quiz.getProgress()
    }
    
    private func showQuizResult() {
        // Get Score
        let score = self.quiz.getQuizScore()
        
        let ac = UIAlertController(title: "Score", message: "Your score is \(score) out of \(self.quiz.numberOfQuestions) questions ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: restartQuiz(_:))
        ac.addAction(okAction)
        self.present(ac, animated: true, completion: nil)
    }
    
    private func restartQuiz(_ alertAction: UIAlertAction? = nil) {
        self.quiz.restartQuiz()
        
        // Display first question and choices
        self.setupView()
        
        // Update Progress Bar
        self.updateProgressBar()
        
        // Enable Buttons
        self.enableTFButtonInteractions()
    }

    // MARK: - IBActions
    @IBAction func answerButtonPressed(_ sender: TFButton) {
        // Disable to prevent multiple taps
        self.disableTFButtonInteractions()
        
        // Check answer
        let isCorrect = self.quiz.checkAnswer(sender.valueIndex)
        
        // Update color border feedback
        sender.updateBorderColorOnAnswer(isCorrect: isCorrect, didFinishFeedback: {
            // Check current question number
            if self.quiz.isQuizInProgress() {
                // Enable button
                self.enableTFButtonInteractions()
                
                // Display next question
                self.updateLabelForNextQuestion()
            } else {
                // No more questions / Quiz Finished
                self.showQuizResult()
            }
            
            // Update Progress Bar
            self.updateProgressBar()
        })
    }
}
