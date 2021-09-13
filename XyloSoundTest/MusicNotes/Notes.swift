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
            case .C: return "C.wav"
            case .D: return "D.wav"
            case .E: return "E.wav"
            case .F: return "F.wav"
            case .G: return "G.wav"
            case .A: return "A.wav"
            case .B: return "B.wav"
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

