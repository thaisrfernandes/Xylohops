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
    
    private let notes: [Note] = [.A, .B, .C, .D]
        
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
    private var platform: Platform!
    private var scoreFeedback: ScoreFeedback!
    
    
    //MARK: - Setup
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        
        self.ground = Ground()
        self.player = Player()
        self.platform = Platform(note: notes[0], position: CGPoint(x: ScreenSize.width/4, y: -(ScreenSize.height/2.4)))
        self.scoreFeedback = ScoreFeedback()
        scoreFeedback.isHidden = true
        
        addChild(ground)
        addChild(player)
        addChild(platform)
        addChild(scoreFeedback)
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
                    
                    let newScore = scoreManager.calculateScore(platform: platform.platform, player: self.player)
                    
                    updateScore(with: newScore)
                }
            }
        }
        
    }
    
    private func checkIfPlayerIsOnTop(contactInfo: SKPhysicsContact) -> Bool {
        guard let bodyA = contactInfo.bodyA.node, let bodyB = contactInfo.bodyB.node else { return false }
        
        let isGroundContact = bodyA.name == NodeNames.ground.rawValue || bodyB.name == NodeNames.ground.rawValue
        
        if isGroundContact { return true }
        
        return bodyA.position.y > bodyB.position.y  // Player is always bodyA
    }
    
    //MARK: - Score and Feedback
    
    private func updateScore(with newScore: ScoreType) {
        self.score += newScore.points
        showFeedback(for: newScore)
    }
    
    private func showFeedback(for score: ScoreType) {
        let newText = "\(score.rawValue)"
        
        self.scoreFeedback.isHidden.toggle()
        self.scoreFeedback.changeText(with: newText)
        
        let scaleAction = SKAction.scale(by: 1.5, duration: 0.5)
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 2)
        let sequence = SKAction.sequence([scaleAction, fadeOut])
        
        self.scoreFeedback.run(sequence) {
            self.scoreFeedback.changeText(with: "")
            self.scoreFeedback.isHidden.toggle()
        }
    }
}
