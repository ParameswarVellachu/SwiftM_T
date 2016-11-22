//
//  TopicsCell.swift
//  SwiftM-Tutor
//
//  Created by MTCHNDT on 22/11/16.
//  Copyright © 2016 MTPL. All rights reserved.
//

import UIKit

class TopicsCell: UITableViewCell {

    
    @IBOutlet var imgtopicThumb: UIImageView!
    @IBOutlet var lblTopicsTittle: UILabel!
    @IBOutlet var btnDoubts: UIButton!
    @IBOutlet var btnTopicsCount: UIButton!
    @IBOutlet var btnTopicsRating: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
