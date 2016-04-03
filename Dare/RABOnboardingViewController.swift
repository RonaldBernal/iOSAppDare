//
//  OnboardingViewController.swift
//  Dare
//
//  Created by Ronald Bernal on 4/3/16.
//  Copyright © 2016 Ronald Bernal. All rights reserved.
//

import UIKit

class RABOnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func endOnboarding(sender: AnyObject) {
        // change to login screen
        self.presentController("login")
    }
    
    func presentController(storyboardId: String) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardId)
        self.presentViewController(controller!, animated: true, completion: nil)
    }
    
}
