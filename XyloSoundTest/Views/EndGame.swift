//
//  EndGame.swift
//  XyloSoundTest
//
//  Created by Gabriela Zorzo on 15/09/21.
//

import Foundation
import SpriteKit

class EndGame: SKScene {
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.backgroundColor = UIColor(named: "Background")!
        
        isGameOver()
    }
    
    func isGameOver() {
        let gameOverLabel = GameOver(score: ScoreManager.shared.score)
        gameOverLabel.position = CGPoint(x: 0, y: 200)
        gameOverLabel.zPosition = 1
        addChild(gameOverLabel)
        
        let playButton = Button(imageNamed: "coelho", buttonAction: { Manager.shared.startOver(self) })
        playButton.button.size = CGSize(width: 50, height: 50)
        playButton.position = CGPoint.zero
        playButton.zPosition = 1
        addChild(playButton)
    }
   
}
