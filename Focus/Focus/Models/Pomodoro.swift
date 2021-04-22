//
//  Pomodoro.swift
//  Focus
//
//  Created by Dmitry Gladilov on 22.04.2021.
//

import Foundation

final class Pomodoro {
    
    var workTime = 25 * 60
    var shortBreak = 5 * 50
    var longBreak = 20 * 60
    
    func setDefaultValues() {
        workTime = 25 * 60
        shortBreak = 5 * 50
        longBreak = 20 * 60
    }
    
    func fetchStoredValues() {
        workTime = UserDefaults.standard.integer(forKey: Keys.workTime)
        shortBreak = UserDefaults.standard.integer(forKey: Keys.shortBreakTime)
        longBreak = UserDefaults.standard.integer(forKey: Keys.longBreakTime)
    }
}

