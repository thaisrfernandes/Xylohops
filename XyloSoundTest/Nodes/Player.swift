//
//  Player.swift
//  XylohopsTestSound
//
//  Created by Thaís Fernandes on 12/09/21.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    static let playerSize = CGSize(width: 45, height: 62)
    let jumpAmmount = Player.playerSize.height * 2.65
    let playerSpeed: CGFloat = 5
    var isJumping: Bool = false
    var lastTouchPoint: CGPoint?
    var lastJumpingPoint: CGPoint?
    
    init() {
        let texture = SKTexture(imageNamed: "coelho")
        let size = Player.playerSize
        
        super.init(texture: texture, color: .clear, size: size)
        
        self.name = NodeNames.player.rawValue
        self.constraints = [.zRotation(SKRange(lowerLimit: 0, upperLimit: 0))]
        self.position = CGPoint(x: 0, y: -(ScreenSize.height/2.6))
        
        setupPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhysics() {
        let physicsBody = SKPhysicsBody(rectangleOf: Player.playerSize)
        physicsBody.isDynamic = true
        physicsBody.usesPreciseCollisionDetection = true
        physicsBody.categoryBitMask = Bitmasks.playerCategory
        physicsBody.collisionBitMask = Bitmasks.platformCategory
        physicsBody.contactTestBitMask = Bitmasks.platformCategory
        physicsBody.affectedByGravity = true
//        physicsBody.friction = 1
        
        self.physicsBody = physicsBody
    }
    
    func move(touchPoint: CGPoint) {
        var newPosition: CGFloat
        
        if let lastTouchPoint = self.lastTouchPoint {
            newPosition = touchPoint.x - lastTouchPoint.x
        } else {
            newPosition = touchPoint.x - (lastJumpingPoint?.x ?? 0)
        }
        
        let signMultiplier: CGFloat = newPosition.sign == .plus ? 1 : -1
        let absoluteNewPosition = newPosition.magnitude
        newPosition = min(10, absoluteNewPosition) * signMultiplier
                
        self.lastTouchPoint = touchPoint
        move(to: newPosition)
    }
    
    private func move(to position: CGFloat) {
        let newPosition = self.position.x + position
        
        let maxRightX = ScreenSize.width / 2
        let maxLeftX = maxRightX * -1
                
        if newPosition > maxLeftX && newPosition < maxRightX {
            self.position.x = newPosition
        }
    }
    
    func jump(touchPoint: CGPoint) {
        self.lastJumpingPoint = touchPoint
        
        if !isJumping {
            self.isJumping.toggle()
            
            toggleDynamic()
            self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: jumpAmmount))
        }
    }
    
    func land() {
        if isJumping {
            self.isJumping.toggle()
            self.lastTouchPoint = nil
            self.lastJumpingPoint = nil
        }
    }
    
    private func toggleDynamic() {
        self.physicsBody?.isDynamic = false
        self.physicsBody?.isDynamic = true
    }
}
