//
//  Congrats.swift
//  XyloSoundTest
//
//  Created by Thaís Fernandes on 15/09/21.
//

import Foundation
import SpriteKit

class Congrats: SKLabelNode, LabelSoundPlayer {
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
            self?.playSound(named: "winSound")
        }
    }
    
    func setUp(score: Int, highScoreValue: Int) {
        let title = SKLabelNode()
        
        let titleFont = UIFont(name: "Dogica_bold", size: 20)

        title.attributedText = NSAttributedString(string: "Congratulations!",
                                                  attributes: [.font: titleFont!,
                                                               .foregroundColor: UIColor(named: "Secondary")!])

        title.position = CGPoint(x: 0, y: 100)
        
        
        let subtitle = SKLabelNode(text: "Your score: \(score)")
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
