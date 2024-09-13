//
//  CustomButton.swift
//  Wordle-iOS
//
//  Created by Matúš Mištrik on 13/09/2024.
//

import SwiftUI

struct CustomButton: View {

    // MARK: - Properties

    @Environment(\.isEnabled) private var isEnabled

    var title: String
    var isLoading = false
    var action: () -> Void

    // MARK: - Body

    var body: some View {
        Button(action: action) {
            if isLoading {
                ProgressView()
                    .tint(.white)
            } else {
                Text(title)
            }
        }
        .buttonStyle(CustomButtonStyle( isEnabled: isEnabled))
        .disabled(isLoading)
    }

}

// MARK: - Preview

#Preview {
    Group {
        CustomButton(title: "Title", isLoading: false, action: {})
        CustomButton(title: "Button", isLoading: true, action: {})
    }
    .padding(.horizontal)
}

