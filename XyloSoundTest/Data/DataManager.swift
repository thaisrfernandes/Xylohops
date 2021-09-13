//
//  DataManager.swift
//  Xylohops
//
//  Created by Joao Gabriel Dourado Cervo on 10/09/21.
//

import Foundation

class DataManager {
    static let shared = DataManager()

    private let userDefaults = UserDefaults.standard
        
    private let highScoreKey: String = "ScoreFromLevel"
    private let levelsDoneKey: String = "levelsDone"
    
    private init() {}
    
    //MARK: - High Score
    
    func getHighScore(forLevelID levelID: Int) -> Int {
        return userDefaults.integer(forKey: "\(highScoreKey)\(levelID)")
    }
    
    func setHighScore(_ newHighScore: Int, forLevelID levelID: Int) {
        let currentHighScore = getHighScore(forLevelID: levelID)
        
        if newHighScore > currentHighScore {
            userDefaults.setValue(newHighScore, forKey: highScoreKey)
        }
    }
    
    //MARK: - Levels
    
    func getDoneLevels() -> [Int] {
        return userDefaults.array(forKey: levelsDoneKey) as? [Int] ?? [Int]()
    }
    
    func saveLevel(_ levelID: Int) {
        var doneLevels = getDoneLevels()
        doneLevels.append(levelID)

        userDefaults.set(doneLevels, forKey: levelsDoneKey)
    }
}
