//
//  MainMenu.swift
//  Xylohops
//
//  Created by Gabriela Zorzo on 10/09/21.
//

import Foundation
import SpriteKit

class MainMenu: SKScene {
    
    private var background: SKSpriteNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        createBackground()
        addPlayButton()
    }
    
    func createBackground() {
        let background = SKSpriteNode(imageNamed: "MainBackground")
        background.name = "Background"
        
        let backgroundSize = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        background.size = backgroundSize
        
        let backgroundPosition = CGPoint.zero
        background.position = backgroundPosition
        
        addChild(background)
    }
    
    func addPlayButton() {
        let playButton = Button(imageNamed: "startButton", buttonAction: {
            Manager.shared.transition(self, toScene: .GameScene, transition: SKTransition.fade(withDuration: 1)) 
        })
        let buttonWidth = ScreenSize.width*276/390
        let buttonHeight = ScreenSize.height*83/844
        playButton.button.size = CGSize(width: buttonWidth, height: buttonHeight)
        playButton.position = CGPoint(x: 0, y: -ScreenSize.height/2 * 0.75)

        playButton.zPosition = 1
        addChild(playButton)
    }
    
}
