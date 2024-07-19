//
//  FlagViewModel.swift
//  GuessGame
//
//  Created by DREAMWORLD on 19/07/24.
//

import Foundation

class FlagViewModel: ObservableObject {
    
    private var countries: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Poland", "Nigeria", "Spain", "UK", "Ukraine", "US"]
    public var questions: [FlagModel] = []
    
    @Published var userScore: Int = 0
    @Published var currentQuestion: FlagModel?
    
    init() {
        createQuestions()
        nextQuestion()
    }
    
    private func createQuestions() {
        var questions: [FlagModel] = []
        
        for country in countries {
            var flags = Array(countries.shuffled().prefix(2).filter { $0 != country })
            flags.append(country)
            let randomizedFlags = flags.shuffled()

            let newQuestion: FlagModel = FlagModel(countryName: country, flags: randomizedFlags, correctAnswer: country)
            
            questions.append(newQuestion)
        }
        self.questions = questions.shuffled()
    }
    
    public func checkUserAnswer(question: FlagModel, userChoice: String) -> Bool {
        if question.correctAnswer == userChoice {
            userScore += 1
            nextQuestion()
            return true
        } else {
            nextQuestion()
            return false
        }
    }
    
    private func nextQuestion() {
        currentQuestion = questions.randomElement()
    }
}


