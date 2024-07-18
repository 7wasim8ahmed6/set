//
//  shapes.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 18.07.24.
//

import SwiftUI

struct StripedPattern: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let stripeWidth: CGFloat = 5
                for x in stride(from: 0, to: geometry.size.width, by: stripeWidth * 2) {
                    path.addRect(CGRect(x: x, y: 0, width: stripeWidth, height: geometry.size.height))
                }
            }
        }
    }
}


struct Oval: Shape {
    let number: Int
    
    func path(in rect: CGRect) -> Path {
        var p = Path()

        // Calculate the size for each ellipse based on the number
        let width = min(rect.width, rect.height)
        let height = width / 2
        
        for i in 0..<number {
            let yOffset = CGFloat(i) * (height + 10) // 10 points gap between ellipses
            let ellipseRect = CGRect(x: (rect.width - width) / 2, y: (rect.height - (height * CGFloat(number) + 10 * CGFloat(number - 1))) / 2 + yOffset, width: width, height: height)
            p.addEllipse(in: ellipseRect)
        }

        return p
    }
}

