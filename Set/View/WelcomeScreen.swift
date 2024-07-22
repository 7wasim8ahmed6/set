//
//  WelcomeScreen.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 22.07.24.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var showWelcomeScreen: Bool
    let welcomeMessage: String
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.8), Color.gray.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Image(systemName: "sparkles")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .foregroundColor(.yellow)
                    .shadow(radius: 10)
                
                Text(welcomeMessage)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .shadow(radius: 10)
                
                Spacer()
                
                Button(action: {
                    showWelcomeScreen = false
                }) {
                    Text("Start Game")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
