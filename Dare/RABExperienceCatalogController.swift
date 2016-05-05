//
//  RABExperienceCatalogController.swift
//  Dare
//
//  Created by Ronald Bernal on 5/4/16.
//  Copyright © 2016 Ronald Bernal. All rights reserved.
//

import UIKit
import Parse

class RABExperienceCatalogController: UITableViewController {

    var experiencesArray: NSArray = []
    var experienceID:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        let nib = UINib(nibName: "ExperiencesViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        
        let query = PFQuery(className: "Experiencias")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                print("Found \(objects!.count) articles")
                self.experiencesArray = objects!
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ExperiencesViewCell
        let imageFromParse = self.experiencesArray[indexPath.row].objectForKey("Image") as? PFFile
        imageFromParse!.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
            let image: UIImage! = UIImage(data: imageData!)!
            cell.experienceImage.image = image
        })
        cell.experienceTitle.text = self.experiencesArray[indexPath.row].objectForKey("Title") as? String
        cell.experienceShortDesc.text = self.experiencesArray[indexPath.row].objectForKey("ShortDescription") as? String
        cell.experiencePrice.text = self.experiencesArray[indexPath.row].objectForKey("Price") as? String
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.experiencesArray.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 216
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        
        experienceID = experiencesArray[indexPath.row].objectId
        performSegueWithIdentifier("experienceID", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if (segue.identifier == "experienceID") {
            let viewController = segue.destinationViewController as! ExperienceDetailViewController
            viewController.experienceID = self.experienceID
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
