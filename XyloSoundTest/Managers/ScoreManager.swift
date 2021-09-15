//
//  ScoreManager.swift
//  XyloSoundTest
//
//  Created by Joao Gabriel Dourado Cervo on 13/09/21.
//

import Foundation
import SpriteKit

struct ScoreManager {
    static var shared = ScoreManager()
    var score: Int = 0
    
    func calculateScore(platform: SKSpriteNode, player: Player, on scene: SKScene) -> ScoreType {
        let platX = platform.convert(platform.position, to: scene).x
        
        let midpoint: CGFloat = platform.size.width / 2
        let platformCenter: CGFloat = platX + midpoint
        
        let playerPosInPlatform = player.position.x - platX + midpoint
        let isPlayerOnRightSide: Bool = player.position.x + player.size.width > platformCenter
        
        let umterco = midpoint / 3
        
        if isPlayerOnRightSide {
            let perfectArea = midpoint + umterco
            let goodArea = perfectArea + (umterco * 1.5)
            
            if playerPosInPlatform < perfectArea {
                return .perfect
            } else if playerPosInPlatform < goodArea {
                return .good
            } else {
                return .bad
            }
        } else {
            let perfectArea = midpoint - umterco
            let goodArea = perfectArea - (umterco * 1.5)
            
            if playerPosInPlatform > perfectArea {
                return .perfect
            } else if playerPosInPlatform > goodArea {
                return .good
            } else {
                return .bad
            }
        }
    }
}
