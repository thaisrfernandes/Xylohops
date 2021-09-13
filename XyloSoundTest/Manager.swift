//
//  Manager.swift
//  Xylohops
//
//  Created by Gabriela Zorzo on 10/09/21.
//

import Foundation
import SpriteKit

class Manager {
    
    enum SceneType {
        case MainMenu, PlayerScene
    }
    
    private init() {}
    static let shared = Manager()
    
    public func launch() {
        firstLaunch()
    }
    
    private func firstLaunch() {
        if !UserDefaults.standard.bool(forKey: "isFirstLaunch") {
            print("This is our first launch")
            
            MusicStatus.shared.setSounds(true)
            
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
            UserDefaults.standard.synchronize()
        }
    }
    
    func getScene(_ sceneType: SceneType) -> SKScene? {
        switch sceneType {
        case .MainMenu:
            return MainMenu(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        case .PlayerScene:
            return GameScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        }
    }
    
    func transition(_ fromScene: SKScene, toScene: SceneType, transition: SKTransition? = nil) {
        guard let scene = getScene(toScene) else {return}
        if let transition = transition {
            scene.scaleMode = .resizeFill
            fromScene.view?.presentScene(scene, transition: transition)
        } else {
            scene.scaleMode = .resizeFill
            fromScene.view?.presentScene(scene)
        }
    }
    
    func run(_ fileName: String, onNode: SKNode) {
        if MusicStatus.shared.getSound() {
            onNode.run(SKAction.playSoundFileNamed(fileName, waitForCompletion: false))
        }
    }
}
