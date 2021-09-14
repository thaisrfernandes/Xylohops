//
//  Platform.swift
//  XylohopsTestSound
//
//  Created by Thaís Fernandes on 12/09/21.
//

import Foundation
import SpriteKit

let platformsHeight: CGFloat = 5

class Platform: SKNode {
    
    var hasNotBeenJumpedOn: Bool = true
    
    var platform: SKSpriteNode = SKSpriteNode()
    
    private var playSound: SKAction!
    
    var note: Note?
    
    init(note: Note) {
        super.init()
                
        self.playSound = SKAction.playSoundFileNamed(note.filename, waitForCompletion: false)
        
        let texture = SKTexture(imageNamed: note.texture)
        
        let size = CGSize(width: texture.size().width, height: texture.size().height)
        
        self.platform = SKSpriteNode(texture: texture, size: size)
        
        self.note = note
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        platform.zPosition = 1
        platform.name = NodeNames.platform.rawValue

        let platformPhysicsBody = SKPhysicsBody(rectangleOf: platform.frame.size)
        platformPhysicsBody.isDynamic = false

        platformPhysicsBody.categoryBitMask = Bitmasks.platformCategory
        platformPhysicsBody.collisionBitMask = Bitmasks.playerCategory
        platformPhysicsBody.contactTestBitMask = Bitmasks.playerCategory
        platformPhysicsBody.friction = 1
        
        platform.physicsBody = platformPhysicsBody
        
        self.addChild(platform)
    }
    
    func playerJumpedOn() {
        if hasNotBeenJumpedOn {
            self.hasNotBeenJumpedOn.toggle()
        }
    }
    
    func playNoteSound() {
        self.run(playSound)
    }
}
