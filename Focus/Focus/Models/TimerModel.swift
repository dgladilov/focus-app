//
//  Timer.swift
//  Focus
//
//  Created by Dmitry Gladilov on 22.04.2021.
//

import Foundation

class TimerModel {
    
    private var timer = Timer()
    var count = 0
    var reps = 0
    
    func start(action: (() -> Void)?) {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            guard let action = action else { return }
            action()
        })
    }
    
    func reset(completion: () -> Void) {
        timer.invalidate()
        completion()
    }
}

