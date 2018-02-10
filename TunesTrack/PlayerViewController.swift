//
//  PlayerViewController.swift
//  TunesTrack
//
//  Created by Cruz, Adrian (Contractor) on 10/4/17.
//  Copyright © 2017 :]. All rights reserved.
//

import UIKit
import AVFoundation

class AMPlayer {
    var audioPlayer : AVAudioPlayer!
    private var fileString: String
    
    init(fileString: String) {
        self.fileString = fileString
    }
    
    func play() throws -> Void {
        // let uri = self.fileString
        let url = URL(fileURLWithPath: self.fileString)
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            if let data = data {
                DispatchQueue.main.async(execute: {
                    self?.audioPlayer = try! AVAudioPlayer(data: data)
                    //audioPlayer.delegate = self
                    self?.audioPlayer.prepareToPlay()
                    self?.audioPlayer.volume = 100
                    self?.audioPlayer.play()
                })
            }
            
        }
            
        task.resume()
    }
    
    func play2() {
        let player = AVQueuePlayer()
        player.removeAllItems()
        player.insert(AVPlayerItem(url: URL(string:self.fileString)!), after: nil)
        player.play()
    }
    
}

class PlayerViewController: UIViewController {
    var track: Track?
    var player: AMPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Player"
        self.view.backgroundColor = UIColor.orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let track = track, let previewUrl = track.previewUrl else {
            self.title = ""
            self.navigationController?.popViewController(animated: animated)
            player = nil
            return
        }

        //AMPlayer(fileString: previewUrl).play2()
        
//        do {
//            player = AMPlayer(fileString: previewUrl)
//            try player?.play()
//        }catch (let error) {
//            print("Something failed: \(error)")
//        }
        
        
        self.title = track.trackName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
