//
//  Timer.swift
//  Focus
//
//  Created by Dmitry Gladilov on 22.04.2021.
//

import Foundation

class TimerModel {
    
    var timer = Timer()
    var count = 0
    var reps = 1
    
    func start(withUpdate action: (() -> Void)?, newTimer: @escaping () -> Void) {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            guard let action = action else { return }
            self.count -= 1
            action()
            
            if self.count <= 0 {
                timer.invalidate()
                self.reps += 1
                newTimer()
                self.start(withUpdate: action, newTimer: newTimer)
            }
        })
    }
    
    func reset(completion: (() -> Void)?) {
        timer.invalidate()
        guard let completion = completion else { return }
        completion()
    }
}

