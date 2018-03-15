//
//  SoundManager.swift
//  TrueFalseStarter
//
//  Created by Jamie MacLean on 12/02/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import AudioToolbox

var gameSound: SystemSoundID = 0
var gameBoo: SystemSoundID = 0
var gameCheer: SystemSoundID = 0

class QuizSounds {
    
    @objc func loadGameStartSound() {
    let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
    let soundURL = URL(fileURLWithPath: pathToSoundFile!)
    AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }

    @objc func playGameStartSound() {
    AudioServicesPlaySystemSound(gameSound)
    }
    
    @objc func loadCheerSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "Cheer", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameCheer)
    }
    
    @objc func playCheerSound() {
        AudioServicesPlaySystemSound(gameCheer)
    }
    
    @objc func loadBooSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "Boo", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameBoo)
    }
    
    @objc func playBooSound() {
        AudioServicesPlaySystemSound(gameBoo)
    }
    
}
