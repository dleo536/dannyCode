//
//  SecondViewController.swift
//  Assignment_6
//
//  Created by Leo, Daniel Christopher on 10/18/18.
//  Copyright © 2018 Leo, Daniel Christopher. All rights reserved.
//

import UIKit
import AVFoundation

class CatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate{

    var catSounds:[CatSound] = []
    var didSelect:IndexPath?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addCatSounds()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addCatSounds(){
        let soundInfo:[(String,String)] = [("cat-angry","Angry"),("cat-furious","Furious"),("cat-meow","Meow"),("cat-sad","Sad"),("cat-scared","Scared"),("cat-squeak","Squeak"),("cat-whining","Whining")];
        
        for sound in soundInfo{
            let soundPath:String? = Bundle.main.path(forResource: sound.0, ofType: "mp3")
            let soundURL:URL = URL(fileURLWithPath: soundPath!)
            var audioPlayer:AVAudioPlayer
            do{
                try audioPlayer = AVAudioPlayer(contentsOf: soundURL)
                audioPlayer.delegate = self
                catSounds.append(CatSound(name:sound.1, audioPlayer:audioPlayer))
            }catch{
                print("Couldn't find file at \(soundURL)")
            }
            
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catSounds.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier:String = "CatSoundCell"
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = catSounds[indexPath.row].name
        cell.imageView?.image = UIImage(named: "cats-1")
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect = indexPath
        let catSound = catSounds[indexPath.row]
        catSound.audioPlayer.prepareToPlay()
        catSound.audioPlayer.play()
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        if didSelect != nil {
        tableView.deselectRow(at: didSelect!, animated: true)
        }
    }

}

