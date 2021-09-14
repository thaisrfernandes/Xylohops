//
//  ScoreFeedback.swift
//  XyloSoundTest
//
//  Created by Joao Gabriel Dourado Cervo on 13/09/21.
//

import Foundation
import SpriteKit

class ScoreFeedback: SKLabelNode {
    init(text: String) {
        super.init()
        
        setup(text: text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(text: String) {
        self.position = CGPoint(x: 0, y: ((ScreenSize.height / 2) - 150))
        
        self.color = .white
        self.fontSize = 30
        self.zPosition = 2
        self.text = text
    }
    
    func changeText(with text: String) {
        self.text = text
    }
}
