//
//  OnboardingViewController.swift
//  Dare
//
//  Created by Ronald Bernal on 4/3/16.
//  Copyright © 2016 Ronald Bernal. All rights reserved.
//

import UIKit

class RABOnboardingLastViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
    }

    @IBAction func endOnboarding(sender: AnyObject) {
        // change to login screen
        self.presentController("loginView")
    }
    
    func presentController(storyboardId: String) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardId)
        self.presentViewController(controller!, animated: true, completion: nil)
    }
    
}
