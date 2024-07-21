//
//  Score.swift
//  Set
//
//  Created by Rauf Wasim Iqbal Ahmed on 21.07.24.
//

import Foundation

struct Score {
    private(set) var points = 0
    private var consecutiveCorrect = 0
    private var startTime: Date?
    private let predefinedTimeLimit: TimeInterval = 60 // 60 seconds

    mutating func startTimer() {
        startTime = Date()
    }

    private mutating func stopTimerAndCalculateBonus() {
        guard let startTime = startTime else { return }
        let timeTaken = Date().timeIntervalSince(startTime)
        let timeSaved = predefinedTimeLimit - timeTaken
        if timeSaved > 0 {
            let bonusPoints = Int(timeSaved / 30)
            points += bonusPoints
        }
    }

    mutating func addCorrectPoints() {
        points += 3
        if consecutiveCorrect != 0 {
            points += consecutiveCorrect + 1
        }
        consecutiveCorrect += 1
        stopTimerAndCalculateBonus()
        startTimer()
    }

    mutating func deductPoints() {
        points -= 1
        consecutiveCorrect = 0
    }
    
    func getRemainingTime() -> TimeInterval {
            guard let startTime = startTime else { return predefinedTimeLimit }
            let elapsedTime = Date().timeIntervalSince(startTime)
            let remainingTime = predefinedTimeLimit - elapsedTime
            return max(remainingTime, 0)
        }
}
