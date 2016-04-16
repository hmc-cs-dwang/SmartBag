//
//  AddItemViewController.swift
//  SmartBag
//
//  Created by Cam on 4/15/16.
//  Copyright © 2016 Cam. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    var key = ""
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var image: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func add(sender: UIButton) {
        let plistManager = PListManager()
        plistManager.addItem(key, item: BagItem(name: name.text!, itemImage: image.text!, itemIn: true))
        dismissViewControllerAnimated(true, completion: nil)
    }
//
//    @IBAction func prepareForUnwind(sender: UIStoryboardSegue) {
//        print("Hit")
//        add()
//    }
    
    
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
 

}
