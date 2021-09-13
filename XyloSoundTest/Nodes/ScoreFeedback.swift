//
//  ScoreFeedback.swift
//  XyloSoundTest
//
//  Created by Joao Gabriel Dourado Cervo on 13/09/21.
//

import Foundation
import SpriteKit

class ScoreFeedback: SKLabelNode {
    override init() {
        super.init()
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.position = CGPoint(x: 0, y: ((ScreenSize.height / 2) - 150))
        
        self.color = .white
        self.fontSize = 35
        self.zPosition = 2
        self.text = ""
    }
    
    func changeText(with text: String) {
        self.text = text
    }
}
