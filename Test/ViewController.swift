//
//  ViewController.swift
//  Test
//
//  Created by Ryan Maxwell on 2016-06-08.
//  Copyright © 2016 Bceen Ventures. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpUI()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func createAccount(sender: UIButton) {
        
        //Create account goes here.
    }
    
    
    @IBAction func signInTouched(sender: AnyObject) {
        
        if passwordTextField.isInvalid()
        {
            //Swhos the error if the password is invalid, as an example is using an alert view but you can show it anyway you want
            let alert = UIAlertController(title: "Alert", message: passwordTextField.errorMessage(), preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    func setUpUI(){
        
        
        //GRADIENT BACKGROUND
         mainView.setBackgroundGradient(UIColor(red: 1.0/255.0, green: 235.0/255.0, blue: 184.0/255.0, alpha: 1.0), color2: UIColor(red: 17.0/255.0, green: 62.0/255.0, blue: 100.0/255.0, alpha: 1.0))
        
        //CREATE ACCOUNT BUTTON
        let newcolor = UIColor(red: 1.0/255.0, green: 235.0/255.0, blue: 184.0/255.0, alpha: 1.0).CGColor
        createAccountButton.layer.backgroundColor = newcolor
        createAccountButton.layer.cornerRadius = 10
        createAccountButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        let fontAttributes = [NSForegroundColorAttributeName : UIColor.blueColor(),
            NSFontAttributeName : UIFont.systemFontOfSize(40)  ]

        //CIRCULAR ICON
        // buttonView.imageWithString(word: "VT", color: UIColor.purpleColor(), circular: true, fontAttributes: fontAttributes)

        
    }
    

}

