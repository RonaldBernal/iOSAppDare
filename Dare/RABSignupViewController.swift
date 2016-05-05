//
//  RABSignupViewController.swift
//  Dare
//
//  Created by Ronald Bernal on 4/2/16.
//  Copyright © 2016 Ronald Bernal. All rights reserved.
//

import UIKit
import Parse

class RABSignupViewController: UIViewController {
    
    @IBOutlet weak var rabEmail: UITextField!
    @IBOutlet weak var rabPassword: UITextField!
    @IBOutlet weak var rabPasswordConfirmation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func signupWasPressed(sender: AnyObject) {
        if rabEmail.text != "" && rabPassword.text != "" && rabPasswordConfirmation.text != "" {
            if rabPassword.text == rabPasswordConfirmation.text {
                let user = PFUser()
                user.username = rabEmail.text
                user.email = rabEmail.text
                user.password = rabPassword.text
            
                user.signUpInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                    if success {
                        print("User signed up successfully")
                    }else {
                        print(error)
                        if error!.code == 202{
                            let alertController = UIAlertController(title: "Oops!", message: "Este usuario ya existe!", preferredStyle: .Alert)
                        
                            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                            
                            }
                            alertController.addAction(OKAction)
                        
                            self.presentViewController(alertController, animated: true, completion: nil)
                        
                        }
                    }
                })
            }else{
                let alertController = UIAlertController(title: "Oops!", message: "Las contraseñas no coinciden!", preferredStyle: .Alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    
                }
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
        }else {
            let alertController = UIAlertController(title: "Oops!", message: "Los campos de correo y contraseña no pueden estar vacíos!", preferredStyle: .Alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func goBack(sender: AnyObject) {
        self.presentController("loginView")
    }
    
    func presentController(storyboardId: String) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardId)
        self.presentViewController(controller!, animated: true, completion: nil)
    }
    
}

extension RABSignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == rabEmail {
            rabPassword.becomeFirstResponder()
        } else if textField == rabPassword {
            rabPasswordConfirmation.becomeFirstResponder()
        } else{
            signupWasPressed(self)
        }
        return true
    }
}
