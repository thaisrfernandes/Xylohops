//
//  TwinkleTwinkle.swift
//  XyloSoundTest
//
//  Created by Gabriela Zorzo on 13/09/21.
//

import Foundation

class HappyBday {
    
    let G = Note.G(octave: Octave.first)
    let A = Note.A(octave: Octave.first)
    let C = Note.C(octave: Octave.second)
    let B = Note.B(octave: Octave.first)
    let D = Note.D(octave: Octave.second)
    let G2 = Note.G(octave: Octave.second)
    let E = Note.E(octave: Octave.second)
    let F = Note.F(octave: Octave.second)
    
    private (set) var song: [Note]

    init(){
        self.song = [G, G, A, G, C, B, G, G, A, G, D, C, G, G, G2, E, C, B, A, F, F, E, C, D, C ]
    }
}
