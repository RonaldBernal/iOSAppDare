//
//  WishDetailViewController.swift
//  Dare
//
//  Created by Ronald Bernal on 5/4/16.
//  Copyright © 2016 Ronald Bernal. All rights reserved.
//

import UIKit
import Parse

class WishDetailViewController: UIViewController {
    
    var wishID:String!
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var wishersName: UILabel!
    @IBOutlet weak var wishDesc: UILabel!
    @IBOutlet weak var wishCost: UILabel!
    @IBOutlet weak var contactPhone: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        let query = PFQuery(className: "Deseos")
        query.getObjectInBackgroundWithId(wishID) {
            (wish: PFObject?, error: NSError?) -> Void in
            if error == nil {
                let youtubeURL = wish!["VideoURL"] as! String
                
                self.webView.allowsInlineMediaPlayback =  true
                self.webView.loadHTMLString("<style>body{background-color:lightgrey; margin: 0; padding: 0;}</style><iframe width=\"\(self.webView.frame.width)\" height=\"\(self.webView.frame.height)\" src=\"\(youtubeURL)?playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
                
                self.wishersName.text = wish!.objectForKey("WishersName") as? String
                self.wishDesc.text = wish!.objectForKey("Description") as? String
                self.wishCost.text!.appendContentsOf((wish!.objectForKey("Cost") as? String)!)
                self.contactPhone.text!.appendContentsOf((wish!.objectForKey("Phone") as? String)!)
            } else{
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    
    }
    @IBAction func donateToThisWish(sender: AnyObject) {
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
    }
}
