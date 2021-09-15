//
//  GameScene.swift
//  XyloSoundTest
//
//  Created by Thaís Fernandes on 12/09/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //MARK: - Properties
    
    private let notes: [Note] = TwinkleTwinkle().song
    
    private var score: Int = 0 {
        didSet {
            if score > 0 {
                print("score", score)
            }
        }
    }
    
    private let scoreManager = ScoreManager()
    
    //MARK: - Nodes
    
    private var ground: Ground!
    private var player: Player!
    private var platforms: PlatformsScenario!
    private var leftWall: Wall!
    private var rightWall: Wall!
    
    //MARK: - Setup
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        
        self.backgroundColor = UIColor(named: "Background")!
        
        self.ground = Ground()
        self.player = Player()
        self.platforms = PlatformsScenario(notes: notes)
        self.leftWall = Wall(isLeft: true)
        self.rightWall = Wall(isLeft: false)
        
        addChild(ground)
        addChild(player)
        addChild(platforms)
        addChild(leftWall)
        addChild(rightWall)
    }
    
    //MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: self) else { return }
        player.jump(touchPoint: touchPoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: self) else { return }
        player.move(touchPoint: touchPoint)
    }
    
    //MARK: - Contact Logic
    
    func didBegin(_ contact: SKPhysicsContact) {
        let isPlayerOnTop: Bool = checkIfPlayerIsOnTop(contactInfo: contact)
        
        if isPlayerOnTop {
            player.land()
            
            if contact.bodyB.categoryBitMask == Bitmasks.platformCategory {
                let platform = contact.bodyB.node!.parent! as! Platform
                
                if platform.hasNotBeenJumpedOn {
                    platform.playNoteSound()
                    
                    platform.playerJumpedOn()
                    
                    let newScore = scoreManager.calculateScore(platform: platform.platform, player: self.player, on: self)
                    
                    updateScore(with: newScore)
                }
            }
        }
    }
    
    private func checkIfPlayerIsOnTop(contactInfo: SKPhysicsContact) -> Bool {
        guard let bodyA = contactInfo.bodyA.node, let bodyB = contactInfo.bodyB.node else { return false }
        
        let isGroundContact = bodyA.name == NodeNames.ground.rawValue || bodyB.name == NodeNames.ground.rawValue
        
        if isGroundContact { return true }
        
        let platformY = bodyB.convert(bodyB.position, to: self).y
        
        return bodyA.position.y > platformY // Player is always bodyA
    }
    
    //MARK: - Score and Feedback
    
    private func updateScore(with newScore: ScoreType) {
        self.score += newScore.points
        showFeedback(for: newScore)
    }
    
    private func showFeedback(for score: ScoreType) {
        let scoreFeedback = ScoreFeedback(text: score.rawValue)
        
        let scaleAction = SKAction.scale(by: 1.5, duration: 0.5)
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 2)
        let sequence = SKAction.sequence([scaleAction, fadeOut])
        
        scoreFeedback.run(sequence) {
            scoreFeedback.removeFromParent()
        }
        
        self.addChild(scoreFeedback)
    }
    
    func animateScenario() {
        self.platforms.position.y -= 2
    }
    
    override func update(_ currentTime: TimeInterval) {
        animateScenario()
    }
}
