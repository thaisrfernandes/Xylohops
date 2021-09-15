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
    var highScore: SKLabelNode!
    var group: SKNode!
    
    init(score: Int) {
        super.init()
        
        DispatchQueue.main.async { [weak self] in
            let highScoreValue = DataManager.shared.getHighScore(forLevelID: 1)
            
            self?.setUp(score: score, highScoreValue: highScoreValue)
        }
    }
    
    func setUp(score: Int, highScoreValue: Int) {
        title = SKLabelNode(text: "Game Over")
        title.fontName = "Dogica_bold"
        title.color = .white
        title.fontSize = 20
        
        group = SKNode()
        group.position = CGPoint(x: 0, y: ((-ScreenSize.height) / 8))
        
        highScore = SKLabelNode(text: "High score: \(highScoreValue)")
        highScore.name = "highScore"
        highScore.fontName = "Dogica_bold"
        highScore.color = .white
        highScore.fontSize = 20
        highScore.position = CGPoint(x: 0, y: 50)
        
        subtitle = SKLabelNode(text: "Your score: \(score)")
        subtitle.fontName = "Dogica_bold"
        subtitle.color = .white
        subtitle.fontSize = 20
        subtitle.position = CGPoint(x: 0, y: 0)

        addChild(title)

        group.addChild(subtitle)
        group.addChild(highScore)
        addChild(group)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
