//
//  Quiz.swift
//  Quizzler
//
//  Created by John Lawrence Salvador on 7/8/20.
//  Copyright © 2020 JLCS Inc. All rights reserved.
//

import Foundation

struct Quiz {
    var correctAnswers = 0
    var currentQuizNumber = 0
    var questions: [Question]
    
    var numberOfQuestions: Int {
        return questions.count
    }
    
    func getQuestion() -> String {
        return questions[currentQuizNumber].q
    }
    
    func getChoices() -> [String] {
        return questions[currentQuizNumber].a
    }
    
    func getProgress() -> Float {
        return Float(self.currentQuizNumber) / Float(self.questions.count)
    }
    
    mutating func getQuizScore() -> Int {
        return self.correctAnswers
    }
    
    mutating func restartQuiz() {
        self.currentQuizNumber = 0
        self.correctAnswers = 0
    }
    
    mutating func checkAnswer(_ answerIndex: Int) -> Bool {
        if questions[currentQuizNumber].correctAnswer == questions[currentQuizNumber].a[answerIndex] {
            correctAnswers += 1
            return true
        }
        return false
    }
    
    mutating func isQuizInProgress() -> Bool {
        // Increment to move to next question
        self.currentQuizNumber += 1
        
        return currentQuizNumber < numberOfQuestions
    }
}


// Sample Questions
extension Quiz {
    /*
    static func sampleQuestions() -> [Question] {
        return [
            Question(description: "Tomatoes are vegetables.", answer: false),
            Question(description: "There are McDonald's on every continent except one.", answer: true),
            Question(description: "America is the world's most populous country.", answer: false),
            Question(description: "Italy is in northern Europe.", answer: false),
            Question(description: "Sonic the Hedgehog has an actual name.", answer: true),
            Question(description: "In Japan they grow triangular watermelons.", answer: false),
            Question(description: "The image of dinosaurs in \"Jurassic Park\" is accurate.", answer: false),
            Question(description: "Both Nicolas Cage and Michael Jackson were married to the same woman.", answer: true),
            Question(description: "Most of the world's countries have used atomic weapons in war.", answer: false),
            Question(description: "Walmart sells more bananas than anything else.", answer: true),
            Question(description: "Humans are the only animals that bury their dead.", answer: false),
            Question(description: "A large chunk of Iceland's population believes in elves.", answer: true),
            Question(description: "There are 115 bridges over the Amazon River.", answer: false),
            Question(description: "Vietnamese is an official language in Canada.", answer: false)
        ]
    }
     */
    
    static func multipleChoiceQuestion() -> [Question] {
        return [
            Question(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], correctAnswer: "Skin"),
            Question(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], correctAnswer: "100"),
            Question(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
            Question(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
            Question(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], correctAnswer: "Watch"),
            Question(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
            Question(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], correctAnswer: "Orange"),
            Question(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], correctAnswer: "Rum"),
            Question(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], correctAnswer: "Gorilla"),
            Question(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia")
        ]
    }
}
