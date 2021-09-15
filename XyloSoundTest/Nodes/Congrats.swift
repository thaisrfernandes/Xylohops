//
//  Congrats.swift
//  XyloSoundTest
//
//  Created by Thaís Fernandes on 15/09/21.
//

import Foundation
import SpriteKit

class Congrats: SKLabelNode {
    
    var title: SKLabelNode!
    var subtitle: SKLabelNode!
    var highScore: SKLabelNode!
    var group: SKNode!
    
    init(score: Int) {
        DataManager.shared.setHighScore(score, forLevelID: 1)
        
        super.init()
        
        DispatchQueue.main.async { [weak self] in
            let highScoreValue = DataManager.shared.getHighScore(forLevelID: 1)
            
            self?.setUp(score: score, highScoreValue: highScoreValue)
        }
    }
    
    func setUp(score: Int, highScoreValue: Int) {
        let title = SKLabelNode(text: "Congratulations!")
        title.fontName = "Dogica_bold"
        title.color = .white
        title.fontSize = 20
        
        let subtitle = SKLabelNode(text: "Your score was \(score)")
        subtitle.fontName = "Dogica_bold"
        subtitle.color = .white
        subtitle.fontSize = 20
        subtitle.position = CGPoint(x: 0, y: 0)
        
        group = SKNode()
        group.position = CGPoint(x: 0, y: ((-ScreenSize.height) / 8))
        
        highScore = SKLabelNode(text: "High score: \(highScoreValue)")
        highScore.name = "highScore"
        highScore.fontName = "Dogica_bold"
        highScore.color = .white
        highScore.fontSize = 20
        highScore.position = CGPoint(x: 0, y: 50)
        
        self.addChild(title)
        
        group.addChild(subtitle)
        group.addChild(highScore)
        self.addChild(group)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
