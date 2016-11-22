//
//  WebService.swift
//  SwiftM-Tutor
//
//  Created by MTCHNDT on 20/10/16.
//  Copyright © 2016 MTPL. All rights reserved.
//

import UIKit
import CoreData


class WebService: NSObject
{
    var dictUserInfo = NSDictionary()
    var strDate = String()
    
    
    // MARK:- Web Service Operation Block **************
    func loginOperation1(strMobileEmail: String, inPutMobileorEmail: String,txtPassword:String) -> Bool
    {
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        strDate = formatter.stringFromDate(date)
        print(strDate)

//        NSString *strUrl = [NSString stringWithFormat:@"%@requestedon=%@&type=verify&%@=%@&password=%@&ostype=ios",MTUTOR_URL,strDate,strMobileEmail,strMobileNumber,txtUserPwd.text];

        let urlStr = String(format:"%@requestedon=%@&type=verify&%@=%@&password=%@&ostype=ios",MTUTOR_URL,strDate,strMobileEmail,inPutMobileorEmail,txtPassword )
        
        
//        let urlStr = MTUTOR_URL + "requestedon=" + strDate + "&type=verify&" + strMobileEmail + "=" + inPutMobileorEmail + "&password=" + txtPassword + "&ostype=ios"
        
        guard let endpoint = NSURL(string: urlStr),
            let data = NSData(contentsOfURL: endpoint) else
        {
                return false
        }
        
        do {
            
            if let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            {
                
                let statusCode = json["returnmsg"] as! String
                if statusCode == "success"
                {
//                    print(json)
                    let prefs = NSUserDefaults.standardUserDefaults()
                    prefs.setObject(json["userid"], forKey: "userid")
                    prefs.synchronize()
                    
                    let deviceAPI = json ["deviceapi"] as! String?
                    if deviceAPI == "true"
                    {
                        deviceApi_postOperation()
                    }
                    getUserInfowithParam(json["userid"] as! String)
                    return true
                }
                else
                {
                    return false
                }
            }
        }
        catch let error as NSError{
            print("\(error)")
        }
        return false
    }
    
    func deviceApi_postOperation() {
        
        let prefs = NSUserDefaults.standardUserDefaults()
        let strUserID = prefs.objectForKey("userid") as! String
        
//        NSString *strUrl = [NSString stringWithFormat:@"%@requestedon=%@&type=devicedetail&userid=%@&imei=%@&deviceid=%@&anotificationkey=%@&mac=%@&ostype=ios",MTUTOR_URL,strDate,strUserID,strUUID,strEmpty,strTokenKeyConvert,strEmpty];

        let strUUID = NSUUID().UUIDString
        let strEmpty = ""
        let strTokenKeyConvert = "123" as String
        
//        let urlStr = String(format:"%@requestedon=%@&type=devicedetail&userid=%@&imei=%@&deviceid=%@&anotificationkey=%@&mac=%@&ostype=ios",MTUTOR_URL,strDate,strUserID,strUUID,strEmpty,strTokenKeyConvert,strEmpty)

        let urlStr = MTUTOR_URL + "requestedon=" + strDate + "&type=devicedetail&userid=" + strUserID + "imei=" + strUUID + "&deviceid=" + strEmpty + "&anotificationkey=" + strTokenKeyConvert + "&mac=" + strEmpty + "&ostype=ios"

        
        guard let endpoint = NSURL(string: urlStr),
            let data = NSData(contentsOfURL: endpoint) else{
                return
        }
        
        do {
            
            if let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            {
                
                let statusCode = json["returnmsg"] as! String
                if statusCode == "success"
                {
                    
                }
            }
        } catch let error as NSError{
            print("\(error)")
        }
    }
    
    func getUserInfowithParam(strUserId: String) {
        
//        NSString *strUrl = [NSString stringWithFormat:@"%@requestedon=%@&type=info&userid=%@&ostype=ios",MTUTOR_URL,strDate,strUserID];

        let urlStr = String(format: "%@requestedon=%@&type=info&userid=%@&ostype=ios",MTUTOR_URL,strDate,strUserId)
        
        guard let endpoint = NSURL(string: urlStr),
            let data = NSData(contentsOfURL: endpoint) else{
                return
        }
        
        do {
            
            if let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            {
                let statusCode = json["returnmsg"] as! String
                if statusCode == "success"
                {
                    dictUserInfo = json
                    getAllContentListParam(json["year_id"] as! String, univID: json["univid"] as! String)
                    
                }
            }
        } catch let error as NSError{
            print("\(error)")
        }
    }
    
    func getAllContentListParam(yearID: String, univID : String) {
        
//        print(dictUserInfo)
//        NSString *strUrl = [NSString stringWithFormat:@"%@uid=%@&type=json&year=%@",COURSE_URL,strUnivID,strYearID];
        
        let urlStr = String(format: "%@uid=%@&type=json&year=%@",COURSE_URL,univID,yearID)
        
        guard let endpoint = NSURL(string: urlStr),
            let data = NSData(contentsOfURL: endpoint) else{
                return
        }
        
        do {
            
            if let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            {
//                print(json)
                savedContentIntoDatabase(json)
                retrievedContentFromDatabase()
            }
        } catch let error as NSError{
            print("\(error)")
        }
    }
    
    func savedContentIntoDatabase(dict:NSDictionary)
    {
        let strUserId = NSUserDefaults.standardUserDefaults().objectForKey("userid")! as! String

        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("CourseDetails",
                                                        inManagedObjectContext:managedContext)
        let device = NSManagedObject(entity: entity!,
                                     insertIntoManagedObjectContext: managedContext)
        let data = NSKeyedArchiver.archivedDataWithRootObject(dict)
        
        device.setValue(strUserId, forKey: "userid")
        device.setValue(data, forKey: "content")
        do {
            try managedContext.save()
//            devices.append(device)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func retrievedContentFromDatabase()
    {
        let strUserId = NSUserDefaults.standardUserDefaults().objectForKey("userid")! as! String
        
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entityDesc =  NSEntityDescription.entityForName("CourseDetails",
                                                        inManagedObjectContext:managedContext)
        let request = NSFetchRequest()
        request.entity = entityDesc
        let pred = NSPredicate(format: "(userid = %@)", strUserId)
        request.predicate = pred
        var matches: NSManagedObject? = nil
//        let error: NSError!
        var objects = try! managedContext.executeFetchRequest(request)
        if objects.count == 0 {
        }
        else
        {
            matches = objects[0] as? NSManagedObject
            let data = matches!.valueForKey("content")!
            let dictJSONLData = NSKeyedUnarchiver.unarchiveObjectWithData(data as! NSData)
            appDelegate.dictJSONLData = dictJSONLData as! NSDictionary
            //            print(appDelegate.dictJSONLData)
//            let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
//            let path : NSString = documentsDirectory.stringByAppendingPathComponent("fullcontents.plist")
//            appDelegate.dictJSONLData.writeToFile(path as String, atomically: true)
        }
    }
    
    func getJsonPostParams()
    {
        
    }
//    func getJsonPostParams()
//    {
//        let customer = [
//            "customer": [
//                "first_name": "Steve",
//                "last_name": "Lastnameson",
//                "email": "steve.lastnameson@example.com",
//                "verified_email": "true",
//                "addresses": [
//                    [
//                        "address1": "123 Oak St",
//                        "city": "Ottawa",
//                        "province": "ON",
//                        "phone": "555-1212",
//                        "zip": "123 ABC",
//                        "last_name": "Lastnameson",
//                        "first_name": "Mother",
//                        "country": "CA",
//                    ],
//                ],
//            ],
//            ] as [String: Any]
//        
//        var request = URLRequest(url: URL(string: shopUrl + "/admin/customers.json")!)
//        request.httpMethod = "POST"
//        request.httpBody = try! JSONSerialization.data(withJSONObject: customer, options: [])
//        
//        URLSession.shared.dataTask(with:request, completionHandler: {(data, response, error) in
//            if error != nil {
//                print(error)
//            } else {
//                do {
//                    guard let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else { return }
//                    
//                    guard let errors = json?["errors"] as? [[String: Any]] else { return }
//                    if errors.count > 0 {
//                        // show error
//                        return
//                    } else {
//                        // show confirmation
//                    }
//                }
//            }
//        }).resume()
//    }
    
}
