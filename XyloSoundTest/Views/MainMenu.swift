//
//  MainMenu.swift
//  Xylohops
//
//  Created by Gabriela Zorzo on 10/09/21.
//

import Foundation
import SpriteKit

class MainMenu: SKScene {
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addPlayButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    func addPlayButton() {
        let playButton = Button(imageNamed: "coelho", buttonAction: {
            Manager.shared.transition(self, toScene: .PlayerScene, transition: SKTransition.fade(withDuration: 1))
            })
        playButton.button.size = CGSize(width: 50, height: 50)
        playButton.position = CGPoint.zero
        playButton.zPosition = 1
        addChild(playButton)
    }
   
}
