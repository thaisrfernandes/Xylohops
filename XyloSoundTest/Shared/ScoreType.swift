//
//  ScoreType.swift
//  XyloSoundTest
//
//  Created by Thaís Fernandes on 12/09/21.
//

import Foundation
import UIKit

enum ScoreType: String {
    case perfect = "Perfect"
    case good = "Good"
    case bad = "Ok"
    
    var points: Int {
        switch self {
        case .perfect:
            return 5
        case .good:
            return 3
        case .bad:
            return 1
        }
    }
}
