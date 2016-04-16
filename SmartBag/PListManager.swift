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

class PListManager: NSObject, DFBlunoDelegate {
    var path = String()
    var dict = NSMutableDictionary()
    
    var delegate: PListManagerDelegate?
    
    var blunoManager: DFBlunoManager?
    
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
        
        dict = NSMutableDictionary(contentsOfFile: path)!
        
        let bluno = DFBlunoManager.sharedInstance()
        
        if let blunoM = bluno as? DFBlunoManager {
            blunoManager = blunoM
            blunoManager!.delegate = self
        }
        
    }
    
    // DFBlunoDelegate functions
    @objc func bleDidUpdateState(bleSupported: Bool) {
        if (bleSupported && blunoManager != nil) {
            blunoManager!.scan()
        }
    }
    
    @objc func didDiscoverDevice(dev: DFBlunoDevice!) {
        // pass
    }
    
    @objc func readyToCommunicate(dev: DFBlunoDevice!) {
        // pass
    }
    
    @objc func didDisconnectDevice(dev: DFBlunoDevice!) {
        print("connection is lost")
    }
    
    @objc func didWriteData(dev: DFBlunoDevice!) {
        // pass
    }
    
    @objc(didReceiveData:Device:) func didReceiveData(data: NSData!, device dev: DFBlunoDevice!) {
        print(String(data))
    }

    
    func addItem(key: String, item: BagItem) {
        dict.setObject(item, forKey: key)
        if dict.writeToFile(path, atomically: false) {
            print("Did add a new item.")
        }
        if delegate != nil {
            delegate!.didChangePlist(self)
        }
    }
    
    func getItem(key: String) -> BagItem? {
        if let item = dict.valueForKey(key) as? BagItem {
            return item
        }
        return nil
    }
    
    func visitItem(key: String) {
        if let item = dict.valueForKey(key) as? BagItem {
            item.itemIn_ = !item.itemIn_
            dict.setObject(item, forKey: key)
        }
        if delegate != nil {
            delegate!.didChangePlist(self)
        }
    }
    
    func getPresentItems() -> [BagItem] {
        var bag = [BagItem]()
        for item in dict.allValues {
            if ((item as? BagItem) != nil) {
                bag.append(item as! BagItem)
            }
        }
        return bag
    }
    
}
