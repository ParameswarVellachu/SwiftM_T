//
//  TopicsView.swift
//  SwiftM-Tutor
//
//  Created by MTCHNDT on 25/10/16.
//  Copyright © 2016 MTPL. All rights reserved.
//

import UIKit



class TopicsView: UIViewController, UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet var tableTopicsList: UITableView!

    var ncolorIndex = 0
    let arrStaticcolorCode = ["#fec144", "#4eb2cc", "#fa9c54", "#74bdac", "#4554f", "#3dcc90", "#8264a6", "#ed595c", "#38bfde", "#fecb68"]

    
    let cellReuseIdentifier = "TextCell"
    
    // MARK:- View controller life Cycle method
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableTopicsList.registerClass(MyCustomCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableTopicsList.delegate = self
        self.tableTopicsList.dataSource = self
    }

    override func viewWillAppear(animated: Bool) {
//        animateTable()
    }
    
    // MARK:- Tableview Delegate method
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print(arrStaticcolorCode[indexPath.row]);
    }
    
    // MARK:- Tableview Data source method
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStaticcolorCode.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! MyCustomCell
        
        cell.selectionStyle = .None
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
        self.tableTopicsList.reloadData()
        
        let cells = self.tableTopicsList.visibleCells
        let tableHeight: CGFloat = self.tableTopicsList.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(30, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options:.TransitionFlipFromLeft, animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
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
