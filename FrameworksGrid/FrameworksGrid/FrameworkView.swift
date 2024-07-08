//
//  FrameworkView.swift
//  FrameworksGrid
//
//  Created by DREAMWORLD on 08/07/24.
//

import SwiftUI

struct FrameworkView: View {
    var framework: Framework
    
    var body: some View {
        VStack {
            Image(framework.imageName)
                .resizable()
                .frame(width: 90, height: 90)
                .aspectRatio(contentMode: .fit)
            
            Text(framework.name)
                .font(.title2)
                .fontWeight(.semibold)
                .scaledToFit()
                .minimumScaleFactor(0.6)
        }
        .padding()
    }
}

//#Preview {
//    FrameworkView(name: "App Clips", imageName: "onBoarding2")
//}
