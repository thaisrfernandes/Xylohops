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
        
        super.init(texture: nil, color: .black, size: size)
        
        var lastPosition = CGPoint(x: 0, y: -(ScreenSize.height/2.6))
        
        let minY: CGFloat = ScreenSize.height/6.8
        
        let maxScreenX: CGFloat = ScreenSize.width / 2.2
        
        for index in 0...(notes.count-1) {
            let note = notes[index]
            
            let platform = Platform(note: note)
                   
            let platformSize = platform.platform.frame.width
            let middleOfPlatform = platformSize / 2

            var minX = lastPosition.x + middleOfPlatform
            var maxX = minX + platformSize
            
            if maxX > maxScreenX {
                maxX -= maxScreenX
                minX -= maxScreenX
            }
            
            print("------")
            print("note", note.color.accessibilityName)
            print("maxScreenX", maxScreenX)
            print("maxX", maxX)
            print("minX", minX)
            
            var xValue: CGFloat = 0.0
            
            if Bool.random() == false {
                minX *= -1
                maxX *= -1
                xValue = CGFloat.random(in: maxX...minX)
                
            } else {
                xValue = CGFloat.random(in: minX...maxX)
            }
            
            
            let yValue = index == 0 ? lastPosition.y : lastPosition.y + minY

            let position = CGPoint(x: xValue, y: yValue)
            
            platform.position = position
            
            lastPosition = position
            
            addChild(platform)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
