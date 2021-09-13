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
        let size = CGSize(width: ScreenSize.width, height: ScreenSize.height * 0.1)
        
        super.init(texture: nil, color: .orange, size: size)
                
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        self.position = CGPoint(x: 0, y: -(ScreenSize.height / 2))
        self.zPosition = 1
        self.name = NodeNames.ground.rawValue
        
        let floorPhysicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        floorPhysicsBody.isDynamic = false
        
        self.physicsBody = floorPhysicsBody
    }
    
}
