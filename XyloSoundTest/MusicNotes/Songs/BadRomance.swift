
import Foundation

class BadRomance {
    
    let A1 = Note.A(octave: .first)
    let B1 = Note.B(octave: .first)
    
    let C2 = Note.C(octave: .second)
    let D2 = Note.D(octave: .second)
    let E2 = Note.E(octave: .second)
    let F2 = Note.F(octave: .second)
    
    private (set) var song: [Note]

    init(){
        self.song = [C2, D2, E2, C2, F2, E2, F2, E2, D2, B1, C2, D2, E2, E2, E2, D2, C2, C2, D2, E2, C2, F2, E2, F2, E2, D2, B1, C2, D2, E2, E2, E2, D2, C2, A1, A1, E2, E2, F2, E2, A1, A1, E2, E2, F2, E2, A1, A1, E2, E2, F2, E2, C2, C2, A1, C2, A1, C2]
    }
}
