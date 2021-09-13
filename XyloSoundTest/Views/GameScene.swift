//
//  GameScene.swift
//  XyloSoundTest
//
//  Created by Thaís Fernandes on 12/09/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private let notes: [Note] = [.A, .B]
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
    private var platforms: PlatformsScenario!
    private var scoreFeedback: ScoreFeedback!
    
    
    //MARK: - Setup
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        
        self.ground = Ground()
        self.player = Player()
        self.platforms = PlatformsScenario(notes: notes)
        self.scoreFeedback = ScoreFeedback()
        scoreFeedback.isHidden = true
        
        addChild(ground)
        addChild(player)
        addChild(platforms)
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
    
    //MARK: - Score and Feedback
    
    private func updateScore(with newScore: ScoreType) {
        self.score += newScore.points
        showFeedback(for: newScore)
    }
    
    private func showFeedback(for score: ScoreType) {
        self.scoreFeedback.isHidden.toggle()
        self.scoreFeedback.changeText(with: score.rawValue)
        
        let scaleAction = SKAction.scale(by: 1.5, duration: 0.5)
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 2)
        let sequence = SKAction.sequence([scaleAction, fadeOut])
        
        self.scoreFeedback.run(sequence) {
            self.scoreFeedback.changeText(with: "")
            self.scoreFeedback.isHidden.toggle()
        }
    }
}
