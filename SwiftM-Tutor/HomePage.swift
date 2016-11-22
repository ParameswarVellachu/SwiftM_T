//
//  HomePage.swift
//  SwiftM-Tutor
//
//  Created by MTCHNDT on 04/10/16.
//  Copyright © 2016 MTPL. All rights reserved.
//

import UIKit


class HomePage: UIViewController {

    // MARK:- View Controller Life Operation Block
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }

    // MARK:- Menu Operation Block
    @IBAction func onMycourseTapped(sender: UIButton){
        
        let dictAll = appDelegate.dictJSONLData
        
        if (dictAll["course"]?["semester"] is [AnyObject]) //Is array?
        {
            let arr = dictAll["course"]?["semester"] as! NSArray
            getArrayFormat(arr)
        }
        else if (dictAll["course"]?["semester"] is [NSObject : AnyObject]) //is dictionary?
        {
            let dict = dictAll["course"]?["semester"] as! NSDictionary
            getDictionaryFormat(dict)
        }
        else
        {
            //is something else
        }
        
        let subjectPage = self.storyboard?.instantiateViewControllerWithIdentifier("subjectID") as! SubjectView
        self.navigationController?.pushViewController(subjectPage, animated: true)
    }

    @IBAction func onAskDoubtTapped(sender: UIButton)
    {
        

    }
    
    @IBAction func onModelQuestionTapped(sender: UIButton) {
    }
    
    @IBAction func onContestTapped(sender: UIButton) {
    }
    
    @IBAction func onWishlistTapped(sender: UIButton)
    {
        let wishListPage = self.storyboard?.instantiateViewControllerWithIdentifier("wishlistID") as! Wishlist
        self.navigationController?.pushViewController(wishListPage, animated: true)
    }
    
    @IBAction func onSticknotesTapped(sender: UIButton) {
    }

    // MARK:- Array Operation Block
    func getArrayFormat(arrSemester:NSArray) -> NSArray
    {
        appDelegate.arrSubjectIDlist = NSMutableArray()
        appDelegate.arrSubjectNamelist = NSMutableArray()
        appDelegate.arrUnitlist = NSMutableArray()
        for (index, _) in arrSemester.enumerate()
        {
            let dictBranch = (arrSemester [index]["branch"] as! NSDictionary)
            let arrSubjectList = dictBranch["subject"] as! NSArray
            getSubjectNamewithSubjectID(arrSubjectList)
        }
        return arrSemester
    }
    
    func getSubjectNamewithSubjectID(arrSubject:NSArray)
    {

        for (index, _) in arrSubject.enumerate()
        {
            let dictSubjectAttrib = (arrSubject [index]["@attributes"] as! NSDictionary)

//            print(arrSubject[index]["unit"] as! NSArray);
            appDelegate.arrSubjectIDlist.addObject(dictSubjectAttrib["id"] as! String)
            appDelegate.arrSubjectNamelist.addObject(dictSubjectAttrib["name"] as! String)

//            print(appDelegate.arrSubjectNamelist);
//            print(arrSubject[index]["unit"] as! NSArray);
            
            if ((arrSubject[index]["unit"] as? NSArray) != nil)  //Is array
            {
                let arrUnitTemp = (arrSubject[index]["unit"] as! NSArray)
                appDelegate.arrUnitlist.addObject(arrUnitTemp)
            }
            else // dictioanry
            {
                let dictSubjectAttrib = (arrSubject [index]["unit"] as! NSDictionary)
                appDelegate.arrUnitlist.addObject(dictSubjectAttrib)
            }


         }

//        print("ID:\(appDelegate.arrSubjectIDlist)")
//        print("Name:\(appDelegate.arrSubjectNamelist)")
    }
    // MARK:- Dictionary Operation Block
    func getDictionaryFormat(dictSemester:NSDictionary) -> NSDictionary
    {
//        print(dictSemester)
        return dictSemester
    }
    
     /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
