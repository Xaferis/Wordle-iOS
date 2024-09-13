//
//  HomeView.swift
//  Wordle-iOS
//
//  Created by Matúš Mištrik on 13/09/2024.
//

import SwiftUI

struct HomeView: View {

    var body: some View {
        VStack {
            Text("Wordle")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 120)

            CustomButton(title: "Play") {
                print("Play button pressed")
            }
            .frame(maxHeight: .infinity, alignment: .center)
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
    }

}

#Preview {
    HomeView()
}
