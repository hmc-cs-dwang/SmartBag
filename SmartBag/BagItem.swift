//
//  BagItem.swift
//  SmartBag
//
//  Created by Cam on 4/15/16.
//  Copyright © 2016 Cam. All rights reserved.
//

import UIKit

class BagItem: NSObject {
    var name_ = ""
    var itemImage_ = ""
    var itemIn_ = false
    var addTime_ = NSDate()
    
    init(name: String, itemImage: String, itemIn: Bool) {
        super.init()
        name_ = name
        itemImage_ = itemImage
        itemIn_ = itemIn
        addTime_ = NSDate.init(timeIntervalSinceNow: 0)
    }
}
