//
//  TwinkleTwinkle.swift
//  XyloSoundTest
//
//  Created by Gabriela Zorzo on 13/09/21.
//

import Foundation

class TwinkleTwinkle {
    
    let C = Note.C(octave: Octave.first)
    let G = Note.G(octave: Octave.first)
    let A = Note.A(octave: Octave.first)
    let F = Note.F(octave: Octave.first)
    let E = Note.E(octave: Octave.first)
    let D = Note.D(octave: Octave.first)
    
    private (set) var song: [Note]

    init(){
        self.song = [C,C,G,G,A,A,G,F,F,E,E,D,D,C,G,G,F,F,E,E,D,G,G,F,F,E,E,D,C,C,G,G,A,A,G,F,F,E,E,D,D,C]
    }
}
