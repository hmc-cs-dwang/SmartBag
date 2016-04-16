//
//  BluetoothConnectViewController.swift
//  SmartBag
//
//  Created by Tony Zhang on 4/15/16.
//  Copyright © 2016 Cam. All rights reserved.
//

import Foundation
import UIKit

class BluetoothConnectViewController : UIViewController, DFBlunoDelegate {
    var blunoManager : DFBlunoManager?
    var blunoDevice : DFBlunoDevice?
    var discovered = false
    
    @IBOutlet weak var segueButton: UIButton!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var loadingIcon: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let bluno = DFBlunoManager.sharedInstance()
        
        if let blunoManager = bluno as? DFBlunoManager {
            blunoManager.delegate = self
            blunoManager.scan()
            loadingIcon.startAnimating()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // DFBlunoDelegate functions
    @objc func bleDidUpdateState(bleSupported: Bool) {
        if (bleSupported && blunoManager != nil) {
            blunoManager!.scan()
        }
    }
    
    @objc func didDiscoverDevice(dev: DFBlunoDevice!) {
        if (dev.identifier == "DFC48FB4-F866-E13C-BB90-9F9E14CA9BDE") {
            loadingLabel.text = "Discovered My SmartBag!"
            discovered = true
            loadingIcon.hidden = true
            
            if (blunoManager != nil) {
                blunoManager!.connectToDevice(dev)
            }
        } else {
            loadingLabel.text = "Discovered a Unrecognized Device"
            discovered = false
        }
    }
    
    @objc func readyToCommunicate(dev: DFBlunoDevice!) {
        if (discovered) {
            loadingLabel.text = "Connected to My SmartBag!"
            blunoDevice = dev
            segueButton.hidden = false
        }
    }
    
    @objc func didDisconnectDevice(dev: DFBlunoDevice!) {
        if (discovered) {
            loadingLabel.text = "Conenction is lost!"
            blunoDevice = nil
            segueButton.hidden = true;
        }
    }
    
    @objc func didWriteData(dev: DFBlunoDevice!) {
        // pass
    }
    
    @objc(didReceiveData:Device:) func didReceiveData(data: NSData!, device dev: DFBlunoDevice!) {
        // pass
    }
    
    @IBAction func enterMainPage(sender: UIButton) {
        self.performSegueWithIdentifier("enterMainViewSeque", sender: self)
    }
}