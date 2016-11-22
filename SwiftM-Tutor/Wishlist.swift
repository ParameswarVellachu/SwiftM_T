//
//  Wishlist.swift
//  SwiftM-Tutor
//
//  Created by MTCHNDT on 22/11/16.
//  Copyright © 2016 MTPL. All rights reserved.
//

import UIKit

class Wishlist: UIViewController {

    @IBOutlet var viewCon: UIView!
    
    @IBOutlet var viewMenu: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBack(sender: UIButton)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func onMenu(sender: UIButton)
    {
        if viewCon.hidden
        {
            viewCon.hidden = false
        }
        else {
            viewCon.hidden = true
            let constraint = NSLayoutConstraint(item: viewMenu, attribute: .Width, relatedBy: .Equal, toItem: viewCon, attribute: .Width, multiplier: 2.0, constant: 0.0)
            
            print(constraint)

        }
    }
    
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
