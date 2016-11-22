//
//  SubjectView.swift
//  SwiftM-Tutor
//
//  Created by MTCHNDT on 25/10/16.
//  Copyright © 2016 MTPL. All rights reserved.
//

import UIKit

// MARK:- Set cell frame adjustment for Custom Cell
class MyCustomCell: UITableViewCell {
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            
            frame.origin.x += 15
            frame.origin.y += 0
            frame.size.width -= 2 * 15
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }
}

class SubjectView: UIViewController, UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet var tableSubjectList: UITableView!

    var ncolorIndex = 0
    let arrStaticcolorCode = ["#fec144", "#4eb2cc", "#fa9c54", "#74bdac", "#4554f", "#3dcc90", "#8264a6", "#ed595c", "#38bfde", "#fecb68"]

    
    let arrSubjectList = ["g","t","tr","tt","g5","t2","tr2","tt1"]
    let cellReuseIdentifier = "TextCell"
    
    // MARK:- View controller life Cycle method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableSubjectList.registerClass(MyCustomCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableSubjectList.delegate = self
        self.tableSubjectList.dataSource = self
    }

    override func viewWillAppear(animated: Bool)
    {
//        animateTable()
        super.viewWillAppear(animated)
        self.navigationItem.title = "SUBJECT LIST"
        self.navigationController?.navigationBarHidden=false
    }
    


    // MARK:- Tableview Delegate method
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let topicsPage = self.storyboard?.instantiateViewControllerWithIdentifier("topicsID") as! TopicsList
        topicsPage.arrTopics = appDelegate.arrUnitlist[indexPath.row] as! NSArray
        topicsPa

        topicsPage.strTitle = appDelegate.arrSubjectNamelist[indexPath.row] as! String
        self.navigationController?.pushViewController(topicsPage, animated: true)
        
//        print(appDelegate.arrSubjectNamelist[indexPath.row]);
//        print(appDelegate.arrUnitlist[indexPath.row]);
    }
    
    // MARK:- Tableview Data source method
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.arrSubjectNamelist.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! MyCustomCell
        
        cell.selectionStyle = .None
        self.tableSubjectList.backgroundColor = UIColor(red: 245.0 / 255.0, green: 244.0 / 255.0, blue: 243.0 / 255.0, alpha: 1.0)
        cell.backgroundColor = UIColor.whiteColor()
        //mail

        var strColor = "ff"
        var ncolorIndex = 0
        if indexPath.row % 10 == 0 {
            let ncolorIndex = indexPath.row % 10
            strColor = self.getColorCodes(ncolorIndex)
        }
        else {
            ncolorIndex = indexPath.row % 10
        }
        strColor = self.getColorCodes(ncolorIndex)
        
        cell.viewWithTag(1000)?.removeFromSuperview()
        cell.viewWithTag(999)?.removeFromSuperview()
        
//        let sizeHeight: CGFloat = 40.0

//        let labelSize = rectForText(appDelegate.arrSubjectNamelist[indexPath.row] as! String, font: UIFont.systemFontOfSize(13.0), maxSize: CGSizeMake(SCREEN_WIDTH-85,999))
        
        
        let labelSize = CGSize().rectForText(appDelegate.arrSubjectNamelist[indexPath.row] as! String, font: UIFont.systemFontOfSize(18.0), maxSize: CGSizeMake(SCREEN_WIDTH,9999))

        let labelHeight = labelSize.height //here it is!
//        let labelWidth = labelSize.width //here it is!

        let sizeHeight: CGFloat = labelHeight
//        let sizeWidth: CGFloat = labelWidth
//        print(sizeWidth)
//        print(SCREEN_WIDTH)
//        print(sizeWidth)
//        print(sizeHeight)
        
        let viewImgContainer = UIView(frame: CGRect(x: 7, y: (cell.frame.size.height-60)/2, width: 60, height: 60))
        viewImgContainer.backgroundColor = UIColor(hexString: strColor)
        viewImgContainer.layer.cornerRadius = 30
        viewImgContainer.layer.borderColor = UIColor.darkGrayColor().CGColor
        viewImgContainer.layer.masksToBounds = true
        viewImgContainer.tag = 999

        let imgNews = UIImageView(frame: CGRect(x: (viewImgContainer.frame.size.width - 32) / 2, y: (viewImgContainer.frame.size.height - 32) / 2, width: 32, height: 32))
        imgNews.image = UIImage(named: "small_thumb")!
        viewImgContainer.addSubview(imgNews)
        cell.addSubview(viewImgContainer)

        //Title
        let lblSubjectName = UILabel()
        lblSubjectName.text = appDelegate.arrSubjectNamelist[indexPath.row] as? String
        lblSubjectName.tag = 1000
        lblSubjectName.frame = CGRect(x: 75, y: (cell.frame.size.height-sizeHeight-10)/2, width: SCREEN_WIDTH-120, height: sizeHeight+10)
        lblSubjectName.lineBreakMode = .ByTruncatingTail
        lblSubjectName.numberOfLines = 0
        lblSubjectName.textColor = UIColor.blackColor()
        lblSubjectName.autoresizingMask = .FlexibleWidth
        
        cell.addSubview(lblSubjectName)
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.darkGrayColor().CGColor
        cell.layer.masksToBounds = true
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clearColor()
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    // MARK:- Tableview animation operation block
    func animateTable() {
        self.tableSubjectList.reloadData()
        
        let cells = self.tableSubjectList.visibleCells
//        let tableHeight: CGFloat = self.tableSubjectList.bounds.size.height
        let tableWidth: CGFloat = self.tableSubjectList.bounds.size.width

        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(30, tableWidth)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options:.TransitionFlipFromLeft, animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 5);
                }, completion: nil)
            
            index += 1
        }
    }

    // MARK:- 10 by 10 set of color block
    func getColorCodes(_nIndex:Int) -> String
    {
        var  strCode: String
        strCode = arrStaticcolorCode[_nIndex]
        return strCode
    }
 
    
//    func rectForText(text: String, font: UIFont, maxSize: CGSize) -> CGSize {
//        let attrString = NSAttributedString.init(string: text, attributes: [NSFontAttributeName:font])
//        let rect = attrString.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
//        let size = CGSizeMake(rect.size.width, rect.size.height)
//        return size
//    }
    
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
