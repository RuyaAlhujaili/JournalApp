//
//  SplashView.swift
//  JournalApp
//
//  Created by Ruya Alhujaili on 30/05/1448 AH.
//

import SwiftUI

struct SplashView: View {

    var body: some View {

        VStack(spacing: 16) {

            Image("AppIconIllustration")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            Text("Journali")
                .font(.system(size: 42, weight: .black))

            Text("Your thoughts, your story")
                .font(.system(size: 18, weight: .light))
                .tracking(1)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    SplashView()
}
