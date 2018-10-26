//
//  FirstViewController.swift
//  Assignment_6
//
//  Created by Leo, Daniel Christopher on 10/18/18.
//  Copyright © 2018 Leo, Daniel Christopher. All rights reserved.
//

import UIKit
import AVFoundation
 
class DrumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate {

    var drumSounds:[DrumSound] = []
    var drumSoundsTwo:[DrumSound] = []
    var drumSoundsOne:[DrumSound] = []
    var didSelect:IndexPath?
     @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addDrumSounds()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addDrumSounds(){
//        let soundInfo:[(String,String)] = [("aak1","Kick1"),("aakick2","Kick2"),("aalhat1","Hi Hat1"),("ah_hat_crisp","Hi Hat 2"),("aasnare1","Snare1"),("aasnare12","Snare2"),("ah_hat_soul","Hi Hat 3")];
        
       
        let drumSetOne = [("aak1","Kick1"),("aalhat1","Hi Hat1"),("aasnare1","Snare1")]
        let drumSetTwo = [("aakick2","Kick2"),("ah_hat_crisp","Hi Hat 2"),("aasnare12","Snare2"),("ah_hat_soul","Hi Hat 3")]
        //let drumList = [drumSetOne, drumSetTwo]
        
        for sound in drumSetOne{
            let soundPath:String? = Bundle.main.path(forResource: sound.0, ofType: "mp3")
            let soundURL:URL = URL(fileURLWithPath: soundPath!)
            var audioPlayer:AVAudioPlayer
            do{
                try audioPlayer = AVAudioPlayer(contentsOf: soundURL)
                drumSoundsOne.append(DrumSound(name:sound.1, audioPlayer:audioPlayer))
                audioPlayer.delegate = self
            }catch{
                print("Couldn't find file at \(soundURL)")
            }
            
            
        }
        for sound in drumSetTwo{
            let soundPath:String? = Bundle.main.path(forResource: sound.0, ofType: "mp3")
            let soundURL:URL = URL(fileURLWithPath: soundPath!)
            var audioPlayer:AVAudioPlayer
            do{
                try audioPlayer = AVAudioPlayer(contentsOf: soundURL)
                drumSoundsTwo.append(DrumSound(name:sound.1, audioPlayer:audioPlayer))
                audioPlayer.delegate = self
            }catch{
                print("Couldn't find file at \(soundURL)")
            }
            
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if section == 0{
            rowCount = drumSoundsOne.count
        }
        if section == 1{
            rowCount = drumSoundsTwo.count
        }
        return rowCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier:String = "DrumSoundCell"
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        
        if indexPath.section == 0{
            cell.textLabel?.text = drumSoundsOne[indexPath.row].name
            cell.imageView?.image = UIImage(named: "drumKitOne")
        }
        
        if indexPath.section == 1{
            cell.textLabel?.text = drumSoundsTwo[indexPath.row].name
            cell.imageView?.image = UIImage(named: "drumKitTwo")
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect = indexPath
        if indexPath.section == 0 {
            let drumSound = drumSoundsOne[indexPath.row]
            drumSound.audioPlayer.prepareToPlay()
            drumSound.audioPlayer.play()
        }
        if indexPath.section == 1 {
            let drumSound = drumSoundsTwo[indexPath.row]
            drumSound.audioPlayer.prepareToPlay()
            drumSound.audioPlayer.play()
        }
        
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionIdentifier:String = ""
        if  section == 0 {
                sectionIdentifier = "Drum Kit 1"
        }
        if section == 1{
            sectionIdentifier = "Drum Kit 2"
        }
        return sectionIdentifier
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 2
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        if didSelect != nil {
            tableView.deselectRow(at: didSelect!, animated: true)
        }
    }
    

    
   
}

