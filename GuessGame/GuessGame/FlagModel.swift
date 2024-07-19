//
//  FlagModel.swift
//  GuessGame
//
//  Created by DREAMWORLD on 19/07/24.
//

import Foundation

struct FlagModel: Identifiable {
    var id: UUID = UUID()
    let countryName: String
    let flags: [String]
    let correctAnswer: String
}
