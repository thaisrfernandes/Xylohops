//
//  MusicPlayer.swift
//  Xylohops
//
//  Created by Gabriela Zorzo on 10/09/21.
//

import Foundation
import SpriteKit

let kSoundState = "kSoundState"

class MusicStatus {
    private init() {}
    static let shared = MusicStatus()
    
    func setSounds(_ state: Bool) {
        UserDefaults.standard.set(state, forKey: kSoundState)
        UserDefaults.standard.synchronize()
    }
    
    func getSound() -> Bool {
        return UserDefaults.standard.bool(forKey: kSoundState)
    }
}
