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
    
    private var soundWarning: Sound!
    
    var displaySound: Bool = true
    
    init(size: CGSize, displaySound: Bool) {
        super.init(size: size)
        self.displaySound = displaySound
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        if displaySound {
            self.soundWarning = Sound()
            displaySoundWarning()
        }
        
        createBackground()
        addPlayButton()
    }
    
    func displaySoundWarning() {
        addChild(soundWarning)
        let wait = SKAction.wait(forDuration: 4)
        self.run(wait) {
            self.soundWarning.run(SKAction.fadeAlpha(to: 0, duration: 1.0)) {
                self.soundWarning.removeFromParent()
            }
        }
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
