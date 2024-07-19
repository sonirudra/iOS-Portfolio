//
//  ContentView.swift
//  GuessGame
//
//  Created by DREAMWORLD on 19/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = FlagViewModel()
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [.init(red: 0.67, green: 0.0, blue: 0.34), .init(red: 0.08, green: 0.12, blue: 0.74)],
                center: .top,
                startRadius: 200,
                endRadius: 700
            )
                .ignoresSafeArea()
            
            
            VStack(spacing: 30) {
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack {
                    if let safeQuestion = viewModel.currentQuestion {
                        QuestionView(viewModel, question: safeQuestion)
                    } else {
                        Text("Loading...")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                .padding(.horizontal, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                VStack {
                    Text("Your Score: \(viewModel.userScore)")
                        .font(.title3.weight(.medium))
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

struct QuestionView: View {
    
    @ObservedObject var viewModel: FlagViewModel
    @State private var shouldShowAlert: Bool = false
    @State private var isCorrectAnswer: Bool = false
    
    var question: FlagModel
    
    init(_ viewModel: FlagViewModel, question: FlagModel) {
        self.viewModel = viewModel
        self.question = question
    }
    
    var body: some View {
        VStack {
            Text("Select the Flag for \(question.countryName).")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.white)
            
            
            ForEach(question.flags, id: \.self) { flagName in
                Button {
                    handleCheckAnswer(userAsnwer: flagName)
                } label: {
                    Image(flagName)
                        .clipShape(.capsule)
                        .shadow(radius: 5)
                        .padding(.all, 5)
                }
                
            }
        }
        .alert(isCorrectAnswer ? "Correct Answer 🚀" : "Wrong Answer 😢", isPresented: $shouldShowAlert) {
            Button("OK") { }
        }

    }
    
    private func handleCheckAnswer(userAsnwer: String) {
        let result = viewModel.checkUserAnswer(question: question, userChoice: userAsnwer)
        
        if result {
            isCorrectAnswer = true
        } else {
            isCorrectAnswer = false
        }
        
        shouldShowAlert = true
    }
}

#Preview {
    ContentView()
}
