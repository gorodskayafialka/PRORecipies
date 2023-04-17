//
//  UIWindow+MotionEnd.swift
//  PRORecipies
//
//  Created by Maksim Neverovskij on 17.04.2023.
//

import SwiftUI

public extension UIWindow {
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: .shakeEnded, object: nil)
        }
        super.motionEnded(motion, with: event)
    }
}
