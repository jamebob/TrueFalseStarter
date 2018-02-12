//
//  soundNanager.swift
//  TrueFalseStarter
//
//  Created by Jamie MacLean on 11/02/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import AudioToolbox

class SoundManager {
    
 var gameSound: SystemSoundID = 0
 var crowdCheer: SystemSoundID = 0
 var crowdBoo: SystemSoundID = 0


     func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }

    @objc func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }

    @objc func loadCrowdCheer() {
        let pathToSoundFile = Bundle.main.path(forResource: "crowd", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &crowdCheer)
    }

     func playCrowdCheer() {
        AudioServicesPlaySystemSound(crowdCheer)
    }

     func loadCrowdBoo() {
        let pathToSoundFile = Bundle.main.path(forResource: "boo", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &crowdBoo)
    }

    @objc func playCrowdBoo() {
        AudioServicesPlaySystemSound(crowdBoo)
    }
}
