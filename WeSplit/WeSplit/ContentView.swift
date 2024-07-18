//
//  ContentView.swift
//  WeSplit
//
//  Created by DREAMWORLD on 18/07/24.
//

import SwiftUI

struct ContentView: View {
    
    private let tipPercentages: [Int] = [10, 15, 20, 25, 0]
    
    @State private var chequeAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 20
    
    private var finalSplitAmount: Double {
        let totalNumberOfPeople = Double(numberOfPeople + 2)
        let selectedTipPercentage = Double(tipPercentage)
        
        let tipAmount = chequeAmount * selectedTipPercentage / 100
        let grandTotal = chequeAmount + tipAmount
        let perPersonAmount = grandTotal / totalNumberOfPeople

        return perPersonAmount
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $chequeAmount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<10) { number in
                            Text("\(number) people")
                        }
                    }
                }
                
                Section("Tip amount") {
                    Picker("Number of people", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) { percentage in
                            Text(percentage, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Each person has to pay") {
                    Text(finalSplitAmount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                }
            }
            .navigationTitle("WeSplit")
        }
    }
}

#Preview {
    ContentView()
}
