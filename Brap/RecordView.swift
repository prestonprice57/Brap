//
//  RecordView.swift
//  Brap
//
//  Created by Preston Price on 10/2/15.
//  Copyright © 2015 BendyStraw. All rights reserved.
//

import Foundation
import AVFoundation

class RecordView: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var filename: UITextField!
    
    var recorder: AVAudioRecorder?
    
    @IBAction func donePressed(sender: AnyObject) {
        print(filename.text)
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func startRecord(sender: AnyObject) {
        // Check to make sure user entered a filename
        if filename.text == "" {
            let alert = UIAlertView()
            alert.title = "Hey"
            alert.message = "Please enter a filename"
            alert.addButtonWithTitle("Okay")
            alert.show()
        } else {
            // Set record settings
            let recordSettings: [String: AnyObject] = [
                AVSampleRateKey:44100.0,
                AVNumberOfChannelsKey:2,
                AVEncoderBitRateKey:16,
                AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue
            ]
            
            // Find path to write recording too
            let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
            let fullPath = documentsDirectory + "/" + filename.text! + ".caf"
            print(fullPath + " this one")
            let soundFileURL = NSURL.fileURLWithPath(fullPath)
            
            // start recording
            do {
                recorder = try AVAudioRecorder(URL: soundFileURL, settings: recordSettings)
                recorder!.delegate = self
                recorder!.meteringEnabled = true
                recorder!.prepareToRecord() // creates/overwrites the file at soundFileURL
            } catch let error as NSError {
                recorder = AVAudioRecorder()
                print(error.localizedDescription)
            }
            recordWithPermission(true)
            
            //recorder?.record()
        }

    }
    
    //Stop recording when user stops holding record button
    @IBAction func endRecord(sender: AnyObject) {
        print("made it here")
        recorder!.stop()
        itemSelected = "4-Stroke"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //set up the recorder
    func setupRecorder() {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let fullPath = documentsDirectory + "/" + filename.text! + ".m4a"
        print(fullPath + " this one")
        let soundFileURL = NSURL.fileURLWithPath(fullPath)
        print(soundFileURL)
        
        if NSFileManager.defaultManager().fileExistsAtPath(soundFileURL.absoluteString) {
            // probably won't happen. want to do something about it?
            print("\(soundFileURL.absoluteString) exists")
        }
        
        let recordSettings:[String : AnyObject] = [
            AVFormatIDKey: NSNumber(unsignedInt:kAudioFormatAppleLossless),
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        
        do {
            recorder = try AVAudioRecorder(URL: soundFileURL, settings: recordSettings)
            recorder!.delegate = self
            recorder!.meteringEnabled = true
            recorder!.prepareToRecord() // creates/overwrites the file at soundFileURL
        } catch let error as NSError {
            recorder = nil
            print(error.localizedDescription)
        }
        
    }
    
    func recordWithPermission(setup:Bool) {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        // ios 8 and later
        if (session.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    print("Permission to record granted")
                    self.setSessionPlayAndRecord()
                    if setup {
                        self.setupRecorder()
                    }
                    self.recorder!.record()
                    
                    data.insert(self.filename.text!, atIndex: data.endIndex-1)
                    print(data)
                } else {
                    print("Permission to record not granted")
                }
            })
        } else {
            print("requestRecordPermission unrecognized")
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder,
        successfully flag: Bool) {
            print("finished recording \(flag)")
            
            // ios8 and later
            let alert = UIAlertController(title: "Recorder",
                message: "Finished Recording",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Keep", style: .Default, handler: {action in
                print("keep was tapped")
            }))
            self.presentViewController(alert, animated:true, completion:nil)
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder,
        error: NSError?) {
            print("\(error!.localizedDescription)")
    }
    
    func setSessionPlayAndRecord() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            print("could not set session category")
            print(error.localizedDescription)
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("could not make session active")
            print(error.localizedDescription)
        }
    }
}