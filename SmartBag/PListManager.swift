//
//  PListManager.swift
//  SmartBag
//
//  Created by Cam on 4/15/16.
//  Copyright © 2016 Cam. All rights reserved.
//

import UIKit

protocol PListManagerDelegate : class {
    func didChangePlist(sender: PListManager)
}

class PListManager: NSObject {
//    var path = String()
//    var dict = NSMutableDictionary() {
//        didSet {
//            if dict.writeToFile(path, atomically: false) {
//                print("Did add a new item.")
//            } else {
//                print("Did not write to the file")
//            }
//            if delegate != nil {
//                print("added to delegate")
//                delegate!.didChangePlist(self)
//            }
//        }
//    }
//
//    
//    var delegate: PListManagerDelegate?
//    
//    override init() {
//        super.init()
//        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
//        let documentsDirectory = paths[0] as! NSString
//        path = documentsDirectory.stringByAppendingPathComponent("itemsPList.plist")
//        
//        let fileManager = NSFileManager.defaultManager()
//        
//        //check if file exists
//        if(!fileManager.fileExistsAtPath(path)) {
//            // If it doesn't, copy it from the default file in the Bundle
//            if let bundlePath = NSBundle.mainBundle().pathForResource("itemsPList", ofType: "plist") {
//                do {
//                    try fileManager.copyItemAtPath(bundlePath, toPath: path)
//                } catch {
//                    
//                }
//                print("copy")
//            } else {
//                print("plist not found. Please, make sure it is part of the bundle.")
//            }
//        } else {
//            print("plist already exits at path.")
//            // use this to delete file from documents directory
//            //fileManager.removeItemAtPath(path, error: nil)
//        }
//        
//        dict = NSMutableDictionary(contentsOfFile: path)!
//    }
//    
//    func addItem(key: String, item: BagItem) {
//        let itemDict = NSMutableDictionary()
//        itemDict["name"] = item.name_
//        itemDict["image"] = item.itemImage_
//        itemDict["time"] = item.addTime_
//        itemDict["in"] = item.itemIn_
//        dict[key] = itemDict
//    }
//    
//    func getItem(key: String) -> BagItem? {
//        print("Trying to get an item.")
//        print(dict)
//        dict = NSMutableDictionary(contentsOfFile: path)!
//        if let itemDict = dict[key] {
//            let item = itemDict as! NSDictionary
//            return BagItem(name: item["name"]! as! String, itemImage: item["image"]! as! String, itemIn: item["in"]! as! Bool, time: item["time"]! as! NSDate)
//        }
//        return nil
//    }
//    
//    func visitItem(key: String) {
//        if let item = dict[key] as? NSMutableDictionary {
//            item["in"] = !(item["in"] as! Bool)
//            dict[key] = item
//        }
//    }
//    
//    func getPresentItems() -> [BagItem] {
//        var bag = [BagItem]()
//        print("OK")
//        print("Dict:")
//        dict = NSMutableDictionary(contentsOfFile: path)!
//        print(dict)
//        for item in dict.allValues {
//            if item["in"]! as! Bool {
//                bag.append(BagItem(name: item["name"]! as! String, itemImage: item["image"]! as! String, itemIn: item["in"]! as! Bool, time: item["time"]! as! NSDate))
//            }
//        }
//        return bag
//    }
    
}
