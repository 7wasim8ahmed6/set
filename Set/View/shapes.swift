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
                let stripeWidth: CGFloat = 2
                for x in stride(from: 0, to: geometry.size.width, by: stripeWidth * 8) {
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

struct Diamond:Shape {
    let number: Int
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let width = min(rect.width, rect.height)
        let height = width / 2
        for i in 0..<number {
            let yOffset = CGFloat(i) * (height + 10) // 10 points gap between diamonds
            let centerX = rect.midX
            let centerY = rect.midY + yOffset - (CGFloat(number - 1) * (height + 10)) / 2
            
            // Define the four points of the diamond
            let topPoint = CGPoint(x: centerX, y: centerY - height / 2)
            let bottomPoint = CGPoint(x: centerX, y: centerY + height / 2)
            let leftPoint = CGPoint(x: centerX - width / 2, y: centerY)
            let rightPoint = CGPoint(x: centerX + width / 2, y: centerY)
            
            // Construct the diamond path
            p.move(to: topPoint)
            p.addLine(to: rightPoint)
            p.addLine(to: bottomPoint)
            p.addLine(to: leftPoint)
            p.addLine(to: topPoint)
        }
        return p
    }
}

struct Squiggle:Shape {
    let number: Int
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let width = min(rect.width, rect.height)
        let height = width / 2
        for i in 0..<number {
                    let yOffset = CGFloat(i) * (height + 10) // 10 points gap between squiggles
                    let startX = (rect.width - width) / 2
                    let startY = (rect.height - (height * CGFloat(number) + 10 * CGFloat(number - 1))) / 2 + yOffset
                    
                    // Move to the starting point of the squiggle
                    p.move(to: CGPoint(x: startX, y: startY + height / 2))
                    
                    // Draw the first curve
                    p.addCurve(to: CGPoint(x: startX + width / 2, y: startY),
                               control1: CGPoint(x: startX + width / 4, y: startY + height / 2),
                               control2: CGPoint(x: startX + width / 4, y: startY))
                    
                    // Draw the second curve
                    p.addCurve(to: CGPoint(x: startX + width, y: startY + height / 2),
                               control1: CGPoint(x: startX + 3 * width / 4, y: startY),
                               control2: CGPoint(x: startX + 3 * width / 4, y: startY + height / 2))
                    
                    // Draw the third curve to complete the loop
                    p.addCurve(to: CGPoint(x: startX + width / 2, y: startY + height),
                               control1: CGPoint(x: startX + 3 * width / 4, y: startY + height / 2),
                               control2: CGPoint(x: startX + 3 * width / 4, y: startY + height))
                    
                    // Draw the fourth curve to complete the loop
                    p.addCurve(to: CGPoint(x: startX, y: startY + height / 2),
                               control1: CGPoint(x: startX + width / 4, y: startY + height),
                               control2: CGPoint(x: startX + width / 4, y: startY + height / 2))
                    
                    // Close the path to ensure it's a closed shape
                    p.closeSubpath()
                }
        return p
    }
}
