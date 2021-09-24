//
//  NotePlayer.swift
//  Xylohops
//
//  Created by Thaís Fernandes on 09/09/21.
//

import Foundation
import UIKit


enum Octave: Int {
    case first = 1
    case second = 2
}

enum Note {
    case C(octave: Octave)      // dó
    case CSharp(octave: Octave) // dó sustenido
    case Db(octave: Octave)     // ré bemol
    case D(octave: Octave)      // ré
    case DSharp(octave: Octave) // ré sustenido
    case Eb(octave: Octave)     // mi bemol
    case E(octave: Octave)      // mi
    case F(octave: Octave)      // fa
    case FSharp(octave: Octave) // fa sustenido
    case Gb(octave: Octave)     // sol bemol
    case G(octave: Octave)      // sol
    case GSharp(octave: Octave) // sol sustenido
    case Ab(octave: Octave)     // la bemol
    case A(octave: Octave)      // la
    case ASharp(octave: Octave) // la sustenido
    case Bb(octave: Octave)     // si bemol
    case B(octave: Octave)      // si

    var filename: String {
        switch self {
            case .C(let octave):
                return "\(octave.rawValue)C.wav"
                
            case .CSharp(let octave), .Db(let octave):
                return "\(octave.rawValue)C#Db.wav"
                
            case .D(let octave):
                return "\(octave.rawValue)D.wav"
                
            case .DSharp(let octave), .Eb(let octave):
                return "\(octave.rawValue)D#Eb.wav"
                
            case .E(let octave):
                return "\(octave.rawValue)E.wav"
                
            case .F(let octave):
                return "\(octave.rawValue)F.wav"
                
            case .FSharp(let octave), .Gb(let octave):
                return "\(octave.rawValue)F#Gb.wav"
                
            case .G(let octave):
                return "\(octave.rawValue)G.wav"
                
            case .GSharp(let octave), .Ab(let octave):
                return "\(octave.rawValue)G#Ab.wav"
                
            case .A(let octave):
                return "\(octave.rawValue)A.wav"
                
            case .ASharp(let octave), .Bb(let octave):
                return "\(octave.rawValue)A#Bb.wav"
                
            case .B(let octave):
                return "\(octave.rawValue)B.wav"
        }
    }
    
    var texture: String {
        switch self {
            case .A, .Ab, .ASharp: return "blue"
            case .B, .Bb: return "red"
            case .C, .CSharp: return "orange"
            case .D, .Db, .DSharp: return "green"
            case .E, .Eb: return "yellow"
            case .F, .FSharp: return "pink"
            case .G, .Gb, .GSharp: return "purple"
        }
    }
}


