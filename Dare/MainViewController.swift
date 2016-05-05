//
//  MainViewController.swift
//  Dare
//
//  Created by Ronald Bernal on 5/4/16.
//  Copyright © 2016 Ronald Bernal. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToExperienceCatalog(sender: AnyObject) {
        presentController("ExperienceNavigationController")
    }
    
    @IBAction func makeAWish(sender: AnyObject) {
        presentController("MakeAWish")
    }
    
    @IBAction func goToWishCatalog(sender: AnyObject) {
        presentController("WishNavigationController")
    }
    
    func presentController(storyboardId: String) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardId)
        self.presentViewController(controller!, animated: true, completion: nil)
    }
}
