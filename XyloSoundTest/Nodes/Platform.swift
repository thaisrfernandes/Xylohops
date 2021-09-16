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
    var topContact: SKNode = SKNode()
    var playedSound: Bool = false
    
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
        
        topContact.zPosition = 1
        topContact.name = NodeNames.platform.rawValue
        
        let topContactPhysics = SKPhysicsBody(rectangleOf: CGSize(width: platform.frame.width - 30, height: 1))
        topContactPhysics.isDynamic = false
        topContactPhysics.categoryBitMask = Bitmasks.platformCategory
        topContactPhysics.collisionBitMask = Bitmasks.playerCategory
        topContactPhysics.contactTestBitMask = Bitmasks.playerCategory
        topContactPhysics.affectedByGravity = false
        
        let contactY = platform.position.y + (platform.size.height / 2)
        
        topContact.physicsBody = topContactPhysics
        topContact.position = CGPoint(x: platform.position.x, y: contactY)
        
        self.addChild(platform)
        self.addChild(topContact)
    }
    
    func playerJumpedOn() {
        if hasNotBeenJumpedOn {
            self.hasNotBeenJumpedOn.toggle()
        }
    }
    
    func playNoteSound() {
        self.run(playSound) {
            self.playedSound = true
        }
    }
}
