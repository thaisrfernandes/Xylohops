//
//  PlatformsScenario.swift
//  XyloSoundTest
//
//  Created by Thaís Fernandes on 13/09/21.
//

import Foundation
import SpriteKit

class PlatformsScenario: SKSpriteNode {
    init(notes: [Note]) {
        let size = CGSize(width: ScreenSize.width, height: ScreenSize.height)
        
        super.init(texture: nil, color: .clear, size: size)
        
        self.zPosition = 1
        
        var lastPosition = CGPoint(x: 0, y: 0)
        
        let minY: CGFloat = Player.playerSize.height * 2.5
        
        let maxScreenX: CGFloat = ScreenSize.width / 2
        
        for index in 0...(notes.count-1) {
            let note = notes[index]
            
            let platform = Platform(note: note)
                   
            let platformSize = platform.platform.frame.width

            let minX = platformSize * 0.90
            let maxX = minX + platformSize
            
            let xDelta: CGFloat = CGFloat.random(in: minX...maxX)
            
            var xValue: CGFloat = lastPosition.x + xDelta
            
            if !Bool.random() {
                xValue = lastPosition.x - xDelta
            }
            
            let safetyArea = platformSize * 0.8
                        
            if xValue > (maxScreenX - safetyArea) {
                xValue = lastPosition.x - xDelta
            } else if xValue < (-maxScreenX + safetyArea) {
                xValue = lastPosition.x + xDelta
            }
            
            let yValue = index == 0 ? lastPosition.y : lastPosition.y + minY

            let position = CGPoint(x: xValue, y: yValue)
            
            print(xValue, "xValue")
            print(safetyArea, "safetyArea")
            print(maxScreenX, "maxScreenX")
            print(xDelta, "xDelta")
            print(ScreenSize.width, "screen width")
            
            platform.position = position
            
            lastPosition = position
            
            addChild(platform)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
