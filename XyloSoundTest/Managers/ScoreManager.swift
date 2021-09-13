//
//  ScoreManager.swift
//  XyloSoundTest
//
//  Created by Joao Gabriel Dourado Cervo on 13/09/21.
//

import Foundation
import SpriteKit

struct ScoreManager {
    func calculateScore(platform: SKSpriteNode, player: Player) -> ScoreType {
        let midpoint: CGFloat = platform.size.width / 2
        let platformCenter: CGFloat = platform.position.x + midpoint
        
        let playerPosInPlatform = player.position.x - platform.position.x + midpoint
        let isPlayerOnRightSide: Bool = player.position.x + player.size.width > platformCenter
        
        let umterco = midpoint / 3
        
        if isPlayerOnRightSide {
            let perfectArea = midpoint + umterco
            let goodArea = perfectArea + umterco
            
            if playerPosInPlatform < perfectArea {
                return .perfect
            } else if playerPosInPlatform < goodArea {
                return .good
            } else {
                return .bad
            }
        } else {
            let perfectArea = midpoint - umterco
            let goodArea = perfectArea - umterco
            
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
