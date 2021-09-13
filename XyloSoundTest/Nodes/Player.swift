//
//  Player.swift
//  XylohopsTestSound
//
//  Created by Thaís Fernandes on 12/09/21.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    let playerSize = CGSize(width: 45, height: 62)
    let playerSpeed: CGFloat = 5
    var isJumping: Bool = false
    var lastTouchPoint: CGPoint?
    var lastJumpingPoint: CGPoint?
    
    init() {
        let texture = SKTexture(imageNamed: "coelho")
        let size = playerSize
        
        super.init(texture: texture, color: .clear, size: size)
        
        self.name = NodeNames.player.rawValue
        self.constraints = [.zRotation(SKRange(lowerLimit: 0, upperLimit: 0))]
        
        self.position = CGPoint(x: 0, y: -(ScreenSize.height/2.4))
        
        setupPhysics()
        startDefaultJumping()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhysics() {
        let physicsBody = SKPhysicsBody(rectangleOf: playerSize)
        physicsBody.isDynamic = true
        physicsBody.usesPreciseCollisionDetection = true
        physicsBody.velocity = CGVector(dx: 10, dy: 10)
        physicsBody.categoryBitMask = Bitmasks.playerCategory
        physicsBody.collisionBitMask = Bitmasks.platformCategory
        physicsBody.contactTestBitMask = Bitmasks.platformCategory
        physicsBody.friction = 1
        
        self.physicsBody = physicsBody
    }
    
    private func startDefaultJumping() {
        let action = SKAction.repeatForever(SKAction.applyImpulse(CGVector(dx: 0, dy: 80), duration: 1.0))
        self.run(action)
    }
    
    func move(touchPoint: CGPoint) {
        var newPosition: CGFloat
        
        if let lastTouchPoint = self.lastTouchPoint {
            newPosition = touchPoint.x - lastTouchPoint.x
        } else {
            newPosition = touchPoint.x - (lastJumpingPoint?.x ?? 0)
        }
        
        if isJumping {
            self.lastTouchPoint = touchPoint
            move(to: newPosition)
        }
    }
    
    private func move(to position: CGFloat) {
        let newPosition = self.position.x + position
        
        let maxRightX = ScreenSize.width/2
        let maxLeftX = maxRightX * -1
                
        if newPosition > maxLeftX && newPosition < maxRightX {
            self.position.x = newPosition
        }
        
    }
    
    func jump(touchPoint: CGPoint) {
        self.lastJumpingPoint = touchPoint
        
        if !isJumping {
            self.isJumping.toggle()

            self.removeAllActions()
            
            self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 80))
        }
    }
    
    func land() {
        if isJumping {
            self.isJumping = false
            self.lastTouchPoint = nil
            self.lastJumpingPoint = nil
            
            startDefaultJumping()
        }
    }
    
}
