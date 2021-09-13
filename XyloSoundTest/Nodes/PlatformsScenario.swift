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
        
        
        let maxRightX = (ScreenSize.width/2)
        let maxLeftX = maxRightX * -1
        
        let maxSpaceBetween: CGFloat = 100.0
        let minSpaceBetween: CGFloat = 50.0
        
        let minY = -(ScreenSize.height/2.6)
        
        let lastPosition = CGPoint(x: 0, y: minY)
        
        let spaceBetween = CGFloat.random(in: 30...100)
        
        for index in 0...(notes.count-1) {
            let note = notes[index]
            
            let xValue = CGFloat.random(in: maxLeftX...maxRightX)
            
            let yValue = index == 0 ? minY : CGFloat.random(in: minSpaceBetween...maxSpaceBetween) + minY

            let platform = Platform(note: note)
            
            platform.platform.position = CGPoint(x: xValue, y: yValue)
            
            self.addChild(platform)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
