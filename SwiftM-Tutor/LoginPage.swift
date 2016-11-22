//
//  LoginPage.swift
//  SwiftM-Tutor
//
//  Created by MTCHNDT on 04/10/16.
//  Copyright © 2016 MTPL. All rights reserved.
//

import UIKit

class LoginPage: UIViewController
{
    @IBOutlet var logoTop: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden=true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLoginAction(sender: AnyObject) {
       
        let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("Login") as! LoginCredential
        self.navigationController?.pushViewController(loginPage, animated: true)

    }
    

    @IBAction func btnRegAction(sender: AnyObject) {
        let registerPage = self.storyboard?.instantiateViewControllerWithIdentifier("Reg") as! RegistrationPage
        self.navigationController?.pushViewController(registerPage, animated: true)
    }

}

