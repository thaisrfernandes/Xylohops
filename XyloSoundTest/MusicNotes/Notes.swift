//
//  NotePlayer.swift
//  Xylohops
//
//  Created by Thaís Fernandes on 09/09/21.
//

import Foundation
import UIKit

enum Note: String {
    case C = "C" //dó
    case D = "D" //ré
    case E = "E" //mi
    case F = "F" //fa
    case G = "G" //sol
    case A = "A" //la
    case B = "B" //si
    
    var filename: String {
        switch self {
            case .C: return "C.mp3"
            case .D: return "D.mp3"
            case .E: return "E.mp3"
            case .F: return "F.mp3"
            case .G: return "G.mp3"
            case .A: return "A.mp3"
            case .B: return "B.mp3"
        }
    }
    
    var color: UIColor {
        switch self {
            case .A: return .blue
            case .B: return .red
            case .C: return .orange
            case .D: return .green
            case .E: return .yellow
            case .F: return .systemPink
            case .G: return .purple
        }
    }
}

