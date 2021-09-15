//
//  Sound.swift
//  XyloSoundTest
//
//  Created by Gabriela Zorzo on 15/09/21.
//

import Foundation
import SpriteKit

class Sound: SKSpriteNode {
    
    init() {
        let size = CGSize(width: ScreenSize.width * 0.01, height: ScreenSize.height)
        
        super.init(texture: nil, color: .clear, size: size)
        
        createBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createBackground() {
        let background = SKSpriteNode(imageNamed: "Sound")
        background.name = "Sound"
        
        let backgroundSize = CGSize(width: ScreenSize.width, height: ScreenSize.height)
        background.size = backgroundSize
        
        let backgroundPosition = CGPoint.zero
        background.position = backgroundPosition
        background.zPosition = 4
        
        addChild(background)
    }
}
