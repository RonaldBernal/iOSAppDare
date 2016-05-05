//
//  ExperienceDetailViewController.swift
//  Dare
//
//  Created by Ronald Bernal on 5/4/16.
//  Copyright © 2016 Ronald Bernal. All rights reserved.
//

import UIKit

class ExperienceDetailViewController: UIViewController {
    
    var experienceID:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
    }
}
