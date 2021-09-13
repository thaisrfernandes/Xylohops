//
//  Walls.swift
//  XyloSoundTest
//
//  Created by Gabriela Zorzo on 13/09/21.
//

import Foundation
import SpriteKit

class Wall: SKSpriteNode {
    // if true, set up on left | if false, set up on right
    init(isLeft : Bool) {
        let size = CGSize(width: ScreenSize.width * 0.01, height: ScreenSize.height)
        
        super.init(texture: nil, color: .clear, size: size)
        
        setUp(isLeft: isLeft)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(isLeft : Bool) {
        var xPosition: CGFloat = 0
        if isLeft {
            xPosition = -ScreenSize.width/2
        } else {
            xPosition = ScreenSize.width/2
        }
        
        self.position = CGPoint(x: xPosition, y: 0)
        self.zPosition = 1
        self.name = NodeNames.wall.rawValue
        
        let wallPhysicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        wallPhysicsBody.isDynamic = false
        
        self.physicsBody = wallPhysicsBody
    }
}
