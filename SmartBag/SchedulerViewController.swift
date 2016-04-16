//
//  SchedulerViewController.swift
//  SmartBag
//
//  Created by Cam on 4/16/16.
//  Copyright © 2016 Cam. All rights reserved.
//

import UIKit
import CoreData

class SchedulerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var itemPicker: UIPickerView!
    
    var itemData = [String]()
    var itemPresent = [Bool]()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemPicker.delegate = self
        itemPicker.dataSource = self
        
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
            let bagItems = results as! [NSManagedObject]
            
            for item in bagItems {
                itemData.append(item.valueForKey("name") as! String)
                itemPresent.append(item.valueForKey("in") as! Bool)
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemData[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func schedule(sender: UIButton) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        let itemStr = itemData[itemPicker.selectedRowInComponent(0)]
        
        messageLabel.text = itemStr + " would be scheduled at " + strDate
        if !itemInBag() {
            update()
        }
    }
    
    func update() {
        let itemStr = itemData[itemPicker.selectedRowInComponent(0)]
        let notification = UILocalNotification()
        notification.alertBody = "Please bring " + itemStr
        notification.alertAction = "Turn on"
        
        notification.fireDate = datePicker.date
        notification.timeZone = datePicker.timeZone
        //        notification.fireDate = NSDate(timeIntervalSinceNow: 2)
        notification.soundName = UILocalNotificationDefaultSoundName
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
    func itemInBag() -> Bool {
        return itemPresent[itemPicker.selectedRowInComponent(0)]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
