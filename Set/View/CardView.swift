//
//  CardView.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 18.07.24.
//

import SwiftUI

enum FillingType {
    case open, solid, striped
}

struct OvalView: View {
    let number: Int
    let fillingType: FillingType
    let color: Color
    
    var body: some View {
        ZStack {
            Oval(number: number)
                .stroke(color, lineWidth: 2)
            if fillingType == .solid
            {
                Oval(number: number).fill(color)
            }
            else if fillingType == .striped
            {
                Oval(number: number)
                    .fill(Color.clear)
                    .overlay(StripedPattern().clipShape(Oval(number: number)).foregroundColor(color))
            }
        }        
    }
}
