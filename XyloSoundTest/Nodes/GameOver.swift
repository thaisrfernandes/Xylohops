//
//  GameOver.swift
//  XyloSoundTest
//
//  Created by Thaís Fernandes on 15/09/21.
//

import Foundation
import SpriteKit

class GameOver: SKLabelNode {
    
    var title: SKLabelNode!
    var subtitle: SKLabelNode!
    
    init(score: Int) {
        super.init()
                
        setUp(score: score)
    }
    
    func setUp(score: Int) {
        let title = SKLabelNode(text: "Game Over")
        title.fontName = "Dogica_bold"
        title.color = .white
        title.fontSize = 20
        
        let subtitle = SKLabelNode(text: "Your score was \(score)")
        subtitle.fontName = "Dogica_bold"
        subtitle.color = .white
        subtitle.fontSize = 20
        subtitle.position = CGPoint(x: 0, y: ((-ScreenSize.height) / 8))
        
        addChild(title)
        addChild(subtitle)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
