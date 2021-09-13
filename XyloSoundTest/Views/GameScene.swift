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
    
    private var hasPlayedSound = false
    private var score: Int = 0 {
        didSet {
            if score > 0 {
                print("score", score)
            }
        }
    }
    
    private var ground: Ground!
    private var player: Player!
    private var platforms: PlatformsScenario!
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        
        self.ground = Ground()
        self.player = Player()
        self.platforms = PlatformsScenario(notes: notes)
        
        addChild(ground)
        addChild(player)
        addChild(platforms)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: self) else { return }
        player.jump(touchPoint: touchPoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: self) else { return }
        player.move(touchPoint: touchPoint)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        player.land()
        
        if contact.bodyB.categoryBitMask == Bitmasks.platformCategory {
            let platform = contact.bodyB.node!.parent! as! Platform
            
            if platform.hasNotBeenJumpedOn {
                platform.playNoteSound()
                
                platform.playerJumpedOn()
                
                updateScore(platform: platform.platform)
            }
        }
    }
    
    func updateScore(platform: SKSpriteNode) {
        let midpoint: CGFloat = platform.size.width / 2
        let platformCenter: CGFloat = platform.position.x + midpoint
        
        let playerPosInPlatform = player.position.x - platform.position.x + midpoint
        let isPlayerOnRightSide: Bool = player.position.x + player.size.width > platformCenter
        
        let umterco = midpoint / 3
        
        if isPlayerOnRightSide {
            let perfectArea = midpoint + umterco
            let goodArea = perfectArea + umterco
            
            // Show on screen?
            if playerPosInPlatform < perfectArea {
                let newScore: ScoreType = .perfect
                self.score += newScore.points
            } else if playerPosInPlatform < goodArea {
                let newScore: ScoreType = .good
                self.score += newScore.points
            } else {
                let newScore: ScoreType = .bad
                self.score += newScore.points
            }
        } else {
            let perfectArea = midpoint - umterco
            let goodArea = perfectArea - umterco
            
            if playerPosInPlatform > perfectArea {
                let newScore: ScoreType = .perfect
                self.score += newScore.points
            } else if playerPosInPlatform > goodArea {
                let newScore: ScoreType = .good
                self.score += newScore.points
            } else {
                let newScore: ScoreType = .bad
                self.score += newScore.points
            }
        }
    }
}
