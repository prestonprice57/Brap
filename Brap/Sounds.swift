//
//  Sounds.swift
//  Brap
//
//  Created by Preston Price on 12/11/15.
//  Copyright © 2015 BendyStraw. All rights reserved.
//

import UIKit

class Sounds: NSObject, NSCoding {
    var soundNames = [String]()
    
    init(soundNames: [String]) {
        self.soundNames = soundNames
    }
    
    required init(coder aDecoder: NSCoder) {
        soundNames = aDecoder.decodeObjectForKey("soundNames") as! [String]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(soundNames, forKey: "soundNames")
    }
}
