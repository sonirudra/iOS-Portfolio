//
//  FrameworkViewModel.swift
//  FrameworksGrid
//
//  Created by DREAMWORLD on 08/07/24.
//

import SwiftUI

final class FrameworkViewModel: ObservableObject {
    var selectedFramework: Framework? {
        didSet {
            self.isShowingDetailView = true
        }
    }
    @Published var isShowingDetailView: Bool = false
}
