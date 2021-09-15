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
        DataManager.shared.setHighScore(ScoreManager.shared.score, forLevelID: 1)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.backgroundColor = UIColor(named: "Background")!
        
        let hasWon = ScoreManager.shared.hasWon
        
        if hasWon {
            isGameWon()
            ScoreManager.shared.hasWon = false
        } else {
            isGameOver()
        }
    }
    
    func isGameOver() {
        let gameOverLabel = GameOver(score: ScoreManager.shared.score)
        gameOverLabel.position = CGPoint(x: 0, y: ScreenSize.height/2*0.3)
        gameOverLabel.zPosition = 1
                
        addChild(gameOverLabel)
        
        let buttonWidth = ScreenSize.width*142/390
        let buttonHeight = ScreenSize.height*45/844
        
        let playButton = Button(imageNamed: "restartButton", buttonAction: { Manager.shared.startOver(self) })
        playButton.button.size = CGSize(width: buttonWidth, height: buttonHeight)
        playButton.position = CGPoint(x: ScreenSize.width/2*0.45, y: -ScreenSize.height/2*0.5)
        playButton.zPosition = 1
        addChild(playButton)
        
        let exitButton = Button(imageNamed: "exitButton", buttonAction: { Manager.shared.transition(self, toScene: .MainMenu) })
        exitButton.button.size = CGSize(width: buttonWidth, height: buttonHeight)
        exitButton.position = CGPoint(x: -ScreenSize.width/2*0.45, y: -ScreenSize.height/2*0.5)
        exitButton.zPosition = 1
        addChild(exitButton)
    }
    
    func isGameWon() {
        let gameOverLabel = Congrats(score: ScoreManager.shared.score)
        gameOverLabel.position = CGPoint(x: 0, y: ScreenSize.height/2*0.3)
        gameOverLabel.zPosition = 1
        addChild(gameOverLabel)
        
        let buttonWidth = ScreenSize.width*139.5/390
        let buttonHeight = ScreenSize.height*42/844
        
        let playButton = Button(imageNamed: "restartButton", buttonAction: { Manager.shared.startOver(self) })
        playButton.button.size = CGSize(width: buttonWidth, height: buttonHeight)
        playButton.position = CGPoint(x: ScreenSize.width/2*0.45, y: -ScreenSize.height/2*0.5)
        playButton.zPosition = 1
        addChild(playButton)
        
        let exitButton = Button(imageNamed: "exitButton", buttonAction: { Manager.shared.transition(self, toScene: .MainMenu) })
        exitButton.button.size = CGSize(width: buttonWidth, height: buttonHeight)
        exitButton.position = CGPoint(x: -ScreenSize.width/2*0.45, y: -ScreenSize.height/2*0.5)
        exitButton.zPosition = 1
        addChild(exitButton)
    }
   
}
