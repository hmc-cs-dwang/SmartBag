//
//  BagTableViewController.swift
//  SmartBag
//
//  Created by Cam on 4/15/16.
//  Copyright © 2016 Cam. All rights reserved.
//

import UIKit
import CoreData

class BagTableViewController: UITableViewController, DFBlunoDelegate {
//    var plistManager: PListManager?
    var bagItems = [NSManagedObject]()
    var visibleItems = [NSManagedObject]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var blunoManager: DFBlunoManager?
    
    var itemId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        plistManager = PListManager()
//        plistManager!.delegate = self
        
        let bluno = DFBlunoManager.sharedInstance()
        
        if let blunoM = bluno as? DFBlunoManager {
            blunoManager = blunoM
            blunoManager!.delegate = self
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return plistManager!.getPresentItems().count
        return visibleItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("item") as! BagItemCellTableViewCell
        cell.itemName.text = visibleItems[indexPath.row].valueForKey("name") as? String
        let imageName = visibleItems[indexPath.row].valueForKey("image") as! String
        if let image = UIImage(named: imageName) {
            cell.itemImage.image = image
        } else {
            cell.itemImage.image = UIImage(named: "default")
        }
        return cell
    }
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("item", forIndexPath: indexPath) as? BagItemCellTableViewCell
//        
////        cell.itemName.text = plistManager!.getPresentItems()[indexPath.row].name_
//        cell!.itemName.text = bagItems[indexPath.row].valueForKey("name")
//        return cell!
//    }
    
//    func didChangePlist(sender: PListManager) {
//        if !isViewLoaded() {
//            tableView.reloadData()
//        }
//    }
    
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
        itemId = NSString(data:data, encoding:NSUTF8StringEncoding) as! String
//        if let _ = plistManager!.getItem(itemId) {
//            plistManager!.visitItem(itemId)
//        } else {
//            self.performSegueWithIdentifier("AddItemSegue", sender: self)
//        }
        if !itemExistsAndFlip(itemId) {
            self.performSegueWithIdentifier("AddItemSegue", sender: self)
        }
        reload()
    }
    
    func itemExistsAndFlip(key: String) -> Bool {
        for item in bagItems {
            if item.valueForKey("id") as! String == key {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                let managedContext = appDelegate.managedObjectContext
                
                item.setValue(!(item.valueForKey("in") as! Bool), forKey: "in")
                
                do {
                    try managedContext.save()
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
                return true
            }
        }
        return false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "AddItemSegue") {
            let addVC = segue.destinationViewController as! AddItemViewController
            addVC.key = itemId
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    func reload() {
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "BagItem")
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            bagItems = results as! [NSManagedObject]
            visibleItems = [NSManagedObject]()
            for item in bagItems {
                if item.valueForKey("in") as! Bool {
                    visibleItems.append(item)
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    

//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        print("Bag items:")
//        print(plistManager!.getPresentItems())
//        tableView.reloadData()
//    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
