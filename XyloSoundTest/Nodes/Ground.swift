//
//  Ground.swift
//  XylohopsTestSound
//
//  Created by Thaís Fernandes on 12/09/21.
//

import Foundation
import SpriteKit

class Ground: SKSpriteNode {
    init() {
        let texture = SKTexture(imageNamed: "ground")

        let size = CGSize(width: texture.size().width, height: texture.size().height)
        
        super.init(texture: texture, color: .clear, size: size)
                
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        self.position = CGPoint(x: 0, y: -(ScreenSize.height / 2.05))
        self.zPosition = 5
        self.name = NodeNames.ground.rawValue
        
        let floorPhysicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        floorPhysicsBody.isDynamic = false
        
        self.physicsBody = floorPhysicsBody
    }
}
