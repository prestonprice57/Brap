//
//  ViewController.swift
//  Brap
//
//  Created by Preston Price on 10/1/15.
//  Copyright © 2015 BendyStraw. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var menuButton: UIBarButtonItem!

    var player = AVAudioPlayer()

    @IBAction func playAudio(sender: AnyObject) {
        let path = NSBundle.mainBundle().pathForResource(itemSelected, ofType:"wav")
        print(path!)
        let fileURL = NSURL(fileURLWithPath: path!)
        
        do {
            try player = AVAudioPlayer(contentsOfURL: fileURL)
            
        } catch {
            print("FAILED")
        }
        player.prepareToPlay()
        player.delegate = self
        player.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName: UIFont(name: "GillSans-Light", size: 18)!
        ]
        print(itemSelected)
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.revealViewController().shouldUseFrontViewOverlay = true
        }
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

