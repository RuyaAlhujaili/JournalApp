//
//  JournalEmptyStateView.swift
//  JournalApp
//
//  Created by Ruya Alhujaili on 30/05/1448 AH.
//

import SwiftUI

struct JournalEmptyStateView: View {

    var body: some View {

        VStack(spacing: 0) {

            Image("EmptyJournalIllustration")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)

            Text("Begin Your Journal")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(
                    Color(red: 175/255, green: 153/255, blue: 253/255)
                )
                .padding(.top, 20)

            Text("Craft your personal diary, tap the\nplus icon to begin")
                .font(.system(size: 18, weight: .regular))
                .multilineTextAlignment(.center)
                .padding(.top, 12)

        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    JournalEmptyStateView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(.dark)
}
