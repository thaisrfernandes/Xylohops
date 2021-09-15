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
    
    private var hideGround: Bool = false {
        didSet {
            self.ground.removeFromParent()
        }
    }
    
    private var score: Int = 0 {
        didSet {
            if score > 0 {
                print("score", score)
            }
        }
    }
    
    private var isGameOver: Bool = false {
        didSet {
            if isGameOver {
                self.removeAllChildren()
                let gameOverLabel = GameOver(score: score)
                addChild(gameOverLabel)
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
    private var scoreFeedback: ScoreFeedback!
    
    //MARK: - Setup
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -30)
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
        
        if isGameOver {
            let newScene = GameScene(size: self.size)
            let animation = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(newScene, transition: animation)

            isGameOver = false
        }
        
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
        self.scoreFeedback = ScoreFeedback(text: score.rawValue)
        
        let scaleAction = SKAction.scale(by: 1.5, duration: 0.5)
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 2)
        let sequence = SKAction.sequence([scaleAction, fadeOut])
        
        scoreFeedback.run(sequence) {
            self.scoreFeedback.removeFromParent()
        }
        
        self.addChild(scoreFeedback)
    }
    
    // MARK: - Scenario Animation
    
    func animateScenario() {
        self.platforms.position.y -= 3
    }
    
    override func update(_ currentTime: TimeInterval) {
        animateScenario()
              
        if !hideGround && self.platforms.position.y < (-(ScreenSize.height/2.2)) {
            self.hideGround = true
        }
        
        if player.position.y < (-(ScreenSize.height/2)) {
            self.isGameOver = true
        }
    }
}
