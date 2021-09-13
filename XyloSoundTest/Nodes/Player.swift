//
//  Player.swift
//  XylohopsTestSound
//
//  Created by Thaís Fernandes on 12/09/21.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    let playerSize = CGSize(width: 30, height: 30)
    let playerSpeed: CGFloat = 5
    var isJumping: Bool = false
    var lastTouchPoint: CGPoint?
    var lastJumpingPoint: CGPoint?
    
    init() {
        let texture = SKTexture(imageNamed: "coelho")
        let size = CGSize(width: 30, height: 30)
        
        super.init(texture: texture, color: .clear, size: size)
        
        self.name = NodeNames.player.rawValue
        self.constraints = [.zRotation(SKRange(lowerLimit: 0, upperLimit: 0))]
        
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
        physicsBody.velocity = CGVector(dx: 5, dy: 5)
        physicsBody.categoryBitMask = Bitmasks.playerCategory
        physicsBody.collisionBitMask = Bitmasks.platformCategory
        physicsBody.contactTestBitMask = Bitmasks.platformCategory
        physicsBody.friction = 1
        
        self.physicsBody = physicsBody
    }
    
    private func startDefaultJumping() {
        let action = SKAction.repeatForever(SKAction.applyImpulse(CGVector(dx: 0, dy: 20), duration: 0.8))
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
        
        self.position.x = newPosition
        
    }
    
    func jump(touchPoint: CGPoint) {
        self.lastJumpingPoint = touchPoint
        
        if !isJumping {
            self.isJumping.toggle()

            self.removeAllActions()
            
            self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20))
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
