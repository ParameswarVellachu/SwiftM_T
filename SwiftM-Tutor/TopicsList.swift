//
//  TopicsList.swift
//  SwiftM-Tutor
//
//  Created by MTCHNDT on 17/11/16.
//  Copyright © 2016 MTPL. All rights reserved.
//

import UIKit

class TopicsList: UITableViewController
{
    var arrTopics = NSArray()
    var strTitle = String()
    var indexTopics = 0

    var ncolorIndex = 0
    let arrStaticcolorCode = ["#fec144gjdf;lkgjdflsk asdfasdf asdfads asdf asdfasdf asdfadsfas adsfdsfds sdfdsfs sdfdsfsd sdfdsfds sdfsdfs dsfs sdfsdfds dsfdsfsdf  sdfdsf dsfds dsfdsfds dsfdsfds dfsfd f params", "#4eb2cc", "#fdsgdfgdfsgdfsgdfsgdfsgdfsgdfsgdfsgdfserterw parameswaran velllachu kannambal ", "#74bdac", "abcedfghijklm,nopqrstuvwxyz 0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890", "#3ddfsgdfgdfsgcc90", "#8264a6", "#dfgdfgdfsgfdsgfs", "#38bfde", "#fecb68"]
    let cellReuseIdentifier = "Cell"

    override func viewDidLoad()
    {
        
        super.viewDidLoad()
       
//        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
//        self.tableView.registerClass(TopicsCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        let dictTopicsRow = arrTopics[4] as! NSDictionary
        let strTopicsTitle = dictTopicsRow["@attributes"]?["name"] as! String
//        let strTopicsTitle = dictTopicsTitle["name"] as! String
        print(strTopicsTitle)


        

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationItem.title = strTitle
        self.navigationController?.navigationBarHidden=false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrTopics.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
//        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath)
//        
//        // For Getting Dynamic Text Width & Height
//        
//        
//        //For Topics container View
//        let viewContainer = UIView(frame: CGRect(x: 5, y: 0, width: SCREEN_WIDTH-10, height: cell.frame.size.height))
//        viewContainer.backgroundColor=UIColor.clearColor()
//        
//        //For Imageview
//        let imgNews = UIImageView(frame: CGRect(x:5, y: (viewContainer.frame.size.height-32)/2, width: 32, height: 32))
//        imgNews.image = UIImage(named: "welcome.png")!
//        viewContainer.addSubview(imgNews)
//        
//        //For Topics Title
//        let lblTitleTopic = UILabel(frame: CGRect(x: imgNews.frame.size.width+10, y: 0, width: SCREEN_WIDTH-20, height: viewContainer.frame.size.height-5))
//        lblTitleTopic.text=arrTopics[indexPath.row] as? String
//        lblTitleTopic.textColor=UIColor.blackColor()
//        lblTitleTopic.numberOfLines = 0;
//        lblTitleTopic.lineBreakMode = .ByTruncatingTail
//        viewContainer.addSubview(lblTitleTopic)
//        
//        cell.addSubview(viewContainer)
//        cell.selectionStyle = .None
//        cell.layer.cornerRadius = 1
//        cell.layer.borderColor = UIColor.darkGrayColor().CGColor
//        cell.layer.masksToBounds = true
//        cell.backgroundColor = UIColor.brownColor()
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TopicsCell
        cell.imgtopicThumb?.image = UIImage(named: "welcome.png")
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
//         let CGSizelbl = CGSize().rectForText(arrStaticcolorCode[indexPath.row], font: UIFont.systemFontOfSize(20.0), maxSize: CGSizeMake(SCREEN_WIDTH, 9999))
//        
//        if CGSizelbl.height > 66
//        {
//            let lblTitleTopic = UILabel()
//            lblTitleTopic.text=arrStaticcolorCode[indexPath.row]
//            lblTitleTopic.numberOfLines = 0;
//            lblTitleTopic.lineBreakMode = .ByTruncatingTail
//            return CGSizelbl.height;
//
//        }
//        else
//        {
            return 80;
//        }
}
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clearColor()
        return headerView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
