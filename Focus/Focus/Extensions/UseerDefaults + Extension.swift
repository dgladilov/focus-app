//
//  UseerDefaults + Extension.swift
//  Focus
//
//  Created by Dmitry Gladilov on 22.04.2021.
//

import Foundation

extension UserDefaults {
    var launchedBefore: Bool {
        set {
            set(newValue, forKey: Keys.launchedBefore)
        }
        get {
            return bool(forKey: Keys.launchedBefore)
        }
    }
}
