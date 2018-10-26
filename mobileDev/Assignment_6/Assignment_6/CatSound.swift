//
//  CatSound.swift
//  Assignment_6
//
//  Created by Leo, Daniel Christopher on 10/18/18.
//  Copyright © 2018 Leo, Daniel Christopher. All rights reserved.
//

import UIKit
import AVFoundation

class CatSound: NSObject {
    var name:String
    var audioPlayer:AVAudioPlayer
    
    init(name:String, audioPlayer:AVAudioPlayer) {
        self.name = name
        self.audioPlayer = audioPlayer
        
    }
}
