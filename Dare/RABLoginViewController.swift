//
//  RABLoginViewController.swift
//  Dare
//
//  Created by Ronald Bernal on 4/2/16.
//  Copyright © 2016 Ronald Bernal. All rights reserved.
//

import UIKit
import Parse

class RABLoginViewController: UIViewController {

    @IBOutlet weak var rabEmail: UITextField!
    @IBOutlet weak var rabPassword: UITextField!
    
    
    @IBOutlet weak var rabLogin: UIButton!
    @IBOutlet weak var rabSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let background = CAGradientLayer().blueColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, atIndex: 0)
        */
                
        rabEmail.text = "ronald.abernal@gmail.com"
        rabPassword.text = "Password123"
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginWasPressed(sender: AnyObject) {
        if rabEmail.text != "" && rabPassword.text != "" {
            PFUser.logInWithUsernameInBackground(rabEmail.text!, password: rabPassword.text!, block: { (user: PFUser?, error: NSError?) -> Void in
                if error == nil {
                    print("user logged in successfully")
                    self.presentController("mainView")
                }
                else {
                    print(error)
                    if error!.code == 101{
                        let alertController = UIAlertController(title: "Oops!", message: "Correo o contraseña inválidos", preferredStyle: .Alert)
                        
                        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                            
                        }
                        alertController.addAction(OKAction)
                        
                        self.presentViewController(alertController, animated: true, completion: nil)

                    }
                }
            })
        }else {
            let alertController = UIAlertController(title: "Oops!", message: "Los campos de correo y contraseña no pueden estar vacíos", preferredStyle: .Alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func signupWasPressed(sender: AnyObject) {
        if rabEmail.text != "" && rabPassword.text != "" {
            let user = PFUser()
            user.username = rabEmail.text
            user.email = rabEmail.text
            user.password = rabPassword.text
            
            user.signUpInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                if success {
                    print("User signed up successfully")
                    self.loginWasPressed(self)
                } else {
                    print(error)
                }
            })
        }else {
            let alertController = UIAlertController(title: "Oops!", message: "Los campos de correo y contraseña no pueden estar vacíos", preferredStyle: .Alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func presentController(storyboardId: String) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardId)
        self.presentViewController(controller!, animated: true, completion: nil)
    }
    
}

extension RABLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == rabEmail {
            rabPassword.becomeFirstResponder()
        } else {
            loginWasPressed(self)
        }
        return true
    }
}
