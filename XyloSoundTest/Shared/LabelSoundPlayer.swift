//
//  LabelSoundPlayer.swift
//  XyloSoundTest
//
//  Created by Joao Gabriel Dourado Cervo on 15/09/21.
//

import Foundation
import SpriteKit

protocol LabelSoundPlayer: SKLabelNode {}

//MARK: - Default implementation

extension LabelSoundPlayer {
    func playSound(named sound: String) {
        let soundAction = SKAction.playSoundFileNamed(sound, waitForCompletion: false)
        
        self.run(soundAction)
    }
}
