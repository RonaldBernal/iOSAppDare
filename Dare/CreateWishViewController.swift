//
//  CreateWishViewController.swift
//  Dare
//
//  Created by Ronald Bernal on 5/4/16.
//  Copyright © 2016 Ronald Bernal. All rights reserved.
//

import UIKit
import Parse

class CreateWishViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var wishDesc: UITextField!
    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var videoURL: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        let alertController = UIAlertController(title: "Video", message: "Para poder pedir un deseo necesitas subir un video a Youtube explicando las razones y detallando el deseo. Por favor ten a la mano la URL de dicho video para pedir tu deseo.", preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            
        }
        alertController.addAction(OKAction)
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(alertController, animated: true, completion: nil)
        })
    }
    @IBAction func MakeWishPressed(sender: AnyObject) {
        if name.text != "" && wishDesc.text != "" && cost.text != "" && Phone.text != "" && videoURL.text != "" {
            self.view.endEditing(true)
            
            let object = PFObject(className: "Deseos")
            object["owner"] = PFUser.currentUser()
            object["WishersName"] = self.name.text
            object["Description"] = self.wishDesc.text
            object["Cost"] = self.cost.text
            object["Phone"] = self.Phone.text
            object["VideoURL"] = self.videoURL.text
            
            
            object.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                if success == true {
                    let alertController = UIAlertController(title: "Recibido!", message: "Hemos recibido tu deseo! Esperamos que pronto se haga realidad", preferredStyle: .Alert)
                    
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                        
                    }
                    alertController.addAction(OKAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    self.presentController("mainView")
                    
                } else {
                    let alertController = UIAlertController(title: "Oops!", message: "Algo salio mal, por favor verifica la información proporcionada y vuelve a intentar", preferredStyle: .Alert)
                    
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                        
                    }
                    alertController.addAction(OKAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            }
            
        }else{
            let alertController = UIAlertController(title: "Oops!", message: "Necesitas llenar todos los campos para pedir tu deseo.", preferredStyle: .Alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func goBackPressed(sender: AnyObject) {
        presentController("mainView")
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
