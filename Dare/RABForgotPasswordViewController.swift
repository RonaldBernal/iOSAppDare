//
//  RABForgotPasswordViewController.swift
//  Dare
//
//  Created by Ronald Bernal on 4/4/16.
//  Copyright © 2016 Ronald Bernal. All rights reserved.
//

import UIKit
import Parse

class RABForgotPasswordViewController: UIViewController {

    @IBOutlet weak var RABEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        
        RABEmail.text = "ronald.abernal@gmail.com"
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func sendEmailWasPressed(sender: AnyObject) {
        
        let emailClean = RABEmail.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        PFUser.requestPasswordResetForEmailInBackground(emailClean) { (success, error) -> Void in
            if (error == nil) {
                let alertController = UIAlertController(title: "Correo Enviado", message: "Se ha enviado un correo a la dirección proporcionada para que puedas recuperar tu contraseña", preferredStyle: .Alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    self.presentController("loginView")
                }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }else {
                let errormessage = error!.userInfo["error"] as! NSString
                let error = UIAlertController(title: "No se puede completar la solicitud, verifica el correo proporcionado o intenta nuevamente más tarde", message: errormessage as String, preferredStyle: .Alert)
                let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                error.addAction(okButton)
                self.presentViewController(error, animated: true, completion: nil)
            }
        }
        
    }
    
    
    @IBAction func goBackWasPressed(sender: AnyObject) {
        self.presentController("loginView")
    }
    
    func presentController(storyboardId: String) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardId)
        self.presentViewController(controller!, animated: true, completion: nil)
    }
}

extension RABForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == RABEmail {
            sendEmailWasPressed(self)
        }
        return true
    }
}