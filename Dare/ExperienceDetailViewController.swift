//
//  ExperienceDetailViewController.swift
//  Dare
//
//  Created by Ronald Bernal on 5/4/16.
//  Copyright © 2016 Ronald Bernal. All rights reserved.
//

import UIKit
import Parse

class ExperienceDetailViewController: UIViewController {
    
    var experienceID:String!
    
    @IBOutlet weak var experienceImage: UIImageView!
    @IBOutlet weak var experienceTitle: UILabel!
    @IBOutlet weak var experienceDesc: UILabel!
    @IBOutlet weak var experienceTel: UILabel!
    @IBOutlet weak var experiencePrice: UILabel!
    @IBOutlet weak var experiencePlace: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        let query = PFQuery(className: "Experiencias")
        query.getObjectInBackgroundWithId(experienceID) {
            (article: PFObject?, error: NSError?) -> Void in
            if error == nil {
                
                let imageFromParse = article!.objectForKey("Image") as? PFFile
                imageFromParse!.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                    let image: UIImage! = UIImage(data: imageData!)!
                    self.experienceImage.image = image
                })
                self.experienceTitle.text = article!.objectForKey("Title") as? String
                self.experienceDesc.text = article!.objectForKey("Description") as? String
                self.experienceTel.text!.appendContentsOf((article!.objectForKey("Phone") as? String)!)
                self.experiencePrice.text = article!.objectForKey("Price") as? String
                self.experiencePlace.text = article!.objectForKey("Location") as? String
            } else{
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    @IBAction func buyExperience(sender: AnyObject) {
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
    }
}
