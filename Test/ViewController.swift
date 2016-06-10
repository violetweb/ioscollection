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
    
    var btn: TransitionSubmitButton!

    
    func setUpUI(){
        
        
        //GRADIENT BACKGROUND
         mainView.setBackgroundGradient(UIColor(red: 6.0/255.0, green: 85.0/255.0, blue: 163.0/255.0, alpha: 1.0), color2: UIColor(red: 7.0/255.0, green: 146.0/255.0, blue: 205.0/255.0, alpha: 1.0))
        
        /*
        let newcolor = UIColor(red: 1.0/255.0, green: 235.0/255.0, blue: 184.0/255.0, alpha: 1.0).CGColor
        createAccountButton.layer.backgroundColor = UIColor.whiteColor().CGColor
        createAccountButton.layer.cornerRadius = 10
        createAccountButton.setTitleColor(UIColor(red: 6.0/255.0, green: 85.0/255.0, blue: 163.0/255.0, alpha: 1.0), forState: .Normal)
        createAccountButton.layer.shadowRadius = 10
        createAccountButton.layer.shadowOffset = CGSize(width: createAccountButton.bounds.size.width + 20,height: createAccountButton.bounds.size.height+20)
        createAccountButton.layer.shadowColor = newcolor

*/
        
        let bg = UIImageView(image: UIImage(named: "Login"))
        bg.frame = self.view.frame
        self.view.addSubview(bg)
        
        btn = TransitionSubmitButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 64, height: 44))
        btn.center = self.view.center
        btn.setTitle("Sign in", forState: .Normal)
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        btn.addTarget(self, action: "onTapButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
        
        let fontAttributes = [NSForegroundColorAttributeName : UIColor.blueColor(),
            NSFontAttributeName : UIFont.systemFontOfSize(40)  ]

        //CIRCULAR ICON
        // buttonView.imageWithString(word: "VT", color: UIColor.purpleColor(), circular: true, fontAttributes: fontAttributes)

        
    }
    

}

