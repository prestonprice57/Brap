//
//  ViewController.swift
//  Brap
//
//  Created by Preston Price on 10/1/15.
//  Copyright © 2015 BendyStraw. All rights reserved.
//

import UIKit
import AVFoundation

import GoogleMobileAds

class ViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var bannerView: GADBannerView!
    var player = AVAudioPlayer()

    @IBAction func playAudio(sender: AnyObject) {
        var path: String?
        var fileURL = NSURL()
        
        if itemSelected == data[0] || itemSelected == data[1] {
            path = NSBundle.mainBundle().pathForResource(itemSelected, ofType:"wav")
            print(path!)
            fileURL = NSURL(fileURLWithPath: path!)
        } else {
            let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
            path = documentsDirectory + "/" + itemSelected + ".m4a"
            fileURL = NSURL(fileURLWithPath: path!)
        }
        
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
            self.revealViewController().reloadInputViews()
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.revealViewController().shouldUseFrontViewOverlay = true
        }
        
        bannerView.adUnitID = "ca-app-pub-2794069200159212//9767489685"
        bannerView.rootViewController = self
        bannerView.loadRequest(GADRequest())
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let savedData = defaults.objectForKey("data") as? [String] {
            data = savedData
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

