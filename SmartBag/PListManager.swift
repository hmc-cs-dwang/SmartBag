//
//  PListManager.swift
//  SmartBag
//
//  Created by Cam on 4/15/16.
//  Copyright © 2016 Cam. All rights reserved.
//

import UIKit

class PListManager: NSObject {
    var path = String()
    var dict = NSMutableDictionary()
    
    override init() {
        super.init()
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! NSString
        path = documentsDirectory.stringByAppendingPathComponent("itemsPList.plist")
        
        let fileManager = NSFileManager.defaultManager()
        
        //check if file exists
        if(!fileManager.fileExistsAtPath(path)) {
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = NSBundle.mainBundle().pathForResource("itemsPList", ofType: "plist") {
                
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                print("Bundle Result.plist file is --> \(resultDictionary?.description)")
                do {
                    try fileManager.copyItemAtPath(bundlePath, toPath: path)
                } catch {
                    
                }
                print("copy")
            } else {
                print("plist not found. Please, make sure it is part of the bundle.")
            }
        } else {
            print("plist already exits at path.")
            // use this to delete file from documents directory
            //fileManager.removeItemAtPath(path, error: nil)
        }
        
        // path = NSBundle.mainBundle().pathForResource(Constant.PLIST_NAME, ofType: "plist")!
        dict = NSMutableDictionary(contentsOfFile: path)!
    }
    

    
}
