//
//  RABWishesTableViewController.swift
//  Dare
//
//  Created by Ronald Bernal on 5/4/16.
//  Copyright © 2016 Ronald Bernal. All rights reserved.
//

import UIKit
import Parse

class RABWishesTableViewController: UITableViewController {
    
    var wishesArray: NSArray = []
    var wishID:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        let nib = UINib(nibName: "WishesViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        
        let query = PFQuery(className: "Deseos")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                self.wishesArray = objects!
                self.tableView.reloadData()
            } else{
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    @IBAction func backToMainPressed(sender: AnyObject) {
        presentController("mainView")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! WishesViewCell
        
        cell.wishersName.text = self.wishesArray[indexPath.row].objectForKey("WishersName") as? String
        cell.shortDesc.text = self.wishesArray[indexPath.row].objectForKey("Description") as? String
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wishesArray.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 76
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        
        wishID = wishesArray[indexPath.row].objectId
        performSegueWithIdentifier("wishID", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if (segue.identifier == "wishID") {
            let viewController = segue.destinationViewController as! WishDetailViewController
            viewController.wishID = self.wishID
        }
        
    }
    
    func presentController(storyboardId: String) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardId)
        self.presentViewController(controller!, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
    }
    
}
