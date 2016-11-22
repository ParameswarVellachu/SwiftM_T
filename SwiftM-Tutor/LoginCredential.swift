//
//  LoginCredential.swift
//  SwiftM-Tutor
//
//  Created by MTCHNDT on 04/10/16.
//  Copyright © 2016 MTPL. All rights reserved.
//

/* Sample Declaration part by Params
 
 let str = "Hello" as NSString
 let str1 : NSString = "hellon"
 
 */


import UIKit
import SystemConfiguration

let webClass = WebService()

class LoginCredential: UIViewController
{

// MARK:- Declaration Part
    @IBOutlet var txtMobileorMail: UITextField!
    @IBOutlet var txtPassword: UITextField!

    
    
// MARK:- View Controller Life Cycle **************
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(animated: Bool)  {
        self.navigationController?.navigationBarHidden=true
    }
    
// MARK:- Other function call **************
    
    func displayAlert(strMessage:String)  {
        let alertController = UIAlertController(title: "M-Tutor", message: strMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default)
        { (result : UIAlertAction) -> Void in
            print("OK")
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func getHomePage()
    {
        let useridStr = NSUserDefaults.standardUserDefaults().objectForKey("userid")
        if (useridStr != nil)
        {
            let homeView = self.storyboard?.instantiateViewControllerWithIdentifier("homeID") as! HomePage
            self.navigationController?.pushViewController(homeView, animated: true)
        }
    }
    
// MARK: - Login **************
    @IBAction func btnLoginAction(sender: AnyObject)
    {
        if txtMobileorMail.text!.isEmpty //Empty check
        {
            displayAlert("Enter the Mobile Number should not be an empty")
        }
        else if txtPassword.text!.isEmpty {
            displayAlert("Enter the Password should not be an empty")
        }
        
        else if validateEmail(txtMobileorMail.text!) // Email validation here;
        {
            print("Email part....")
            if txtMobileorMail.text == "paramsinfo@gmail.com" && txtPassword.text == "123456" {
                
                if Reachability.isConnectedToNetwork() == true {
                    print("Internet connection OK")
                    let bSuccess = webClass.loginOperation1("emailid", inPutMobileorEmail: txtMobileorMail.text!, txtPassword: txtPassword.text!) as Bool
                    if bSuccess == true
                    {
                        getHomePage()
                    }
                    else
                    {
                        displayAlert("Invalid Email or Password...")
                    }
                    
                 }
                else {
                    displayAlert("No Internet connection...")
                }
                
            }
            else {
                displayAlert("Invalid Email or Password...")
            }
        }
        else // Mobile Number validation
        {
            print("Mobile Number part....")

            var strMob = String()

            if validateMobnumber(txtMobileorMail.text!)
            {
                print("Number Validation");
                
                if txtMobileorMail.text?.characters.count<10  {
                    displayAlert("Enter the Mobile Number atleast 10 or 12 digits")
                }
                else if txtMobileorMail.text?.characters.count==10  {
                    strMob = "91" + txtMobileorMail.text! as String
                    print(strMob);
                    
                    if strMob == "919940794792" && txtPassword.text == "1234567"  {
                        
                        if Reachability.isConnectedToNetwork() == true  {
                            let bSuccess = webClass.loginOperation1("mobilenumber", inPutMobileorEmail: strMob, txtPassword: txtPassword.text!)
//                            getHomePage()
                            
                            if bSuccess == true
                            {
                                getHomePage()
                            }
                            else
                            {
                                displayAlert("Invalid Email or Password...")
                            }

                            
                            

                        }
                        else  {
                            displayAlert("No Internet connection...")
                        }
                    }
                    else  {
                        displayAlert("Invalid Mobile or Password")
                    }
                    
                }
                else if txtMobileorMail.text?.characters.count==12  {
                    strMob = txtMobileorMail.text! as String
                    print(strMob);
                    
                    if strMob == "019940794792" && txtPassword.text == "123456" {
                        
                        if Reachability.isConnectedToNetwork() == true  {
                            let bSuccess = webClass.loginOperation1("mobilenumber", inPutMobileorEmail: strMob, txtPassword: txtPassword.text!)
//                            getHomePage()
                            
                            if bSuccess == true
                            {
                                getHomePage()
                            }
                            else
                            {
                                displayAlert("Invalid Email or Password...")
                            }
                        }
                        else {
                            displayAlert("No Internet connection...")
                        }
                    }
                    else {
                        displayAlert("Invalid Mobile or Password")
                    }
                }
                else   {
                    displayAlert("Invalid Mobile Number")
                }
            }
            else  {
                displayAlert("Invalid Mobile Number")
            }
        }
    }
    
    @IBAction func btnForgetAction(sender: AnyObject) {

    }
    
    
// MARK:- Validation **************
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluateWithObject(enteredEmail)
    }
    
    func validateMobnumber(value: String) -> Bool {
        let charcter  = NSCharacterSet(charactersInString: "0123456789").invertedSet
        var filtered:NSString!
        let inputString:NSArray = value.componentsSeparatedByCharactersInSet(charcter)
        filtered = inputString.componentsJoinedByString("")
        return  value == filtered
    }

    
// MARK:- Memory Warning **************
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
