//
//  TaskTableViewCell.swift
//  Standup.ios
//
//  Created by julien on 4/5/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    var checkbox: M13Checkbox?{
        didSet{
            let newAddedCheckbox = checkbox!
            newAddedCheckbox.frame.origin.y = (self.frame.height - newAddedCheckbox.frame.height)/2
            newAddedCheckbox.addTarget(self, action: #selector(checkChangedValue(_:)), forControlEvents: .ValueChanged)
            self.addSubview(newAddedCheckbox)
        }
    }
    var id: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel!.frame.origin.x = 30
    }
    func checkChangedValue(sender: M13Checkbox){
        let tableCell = sender.superview as! TaskTableViewCell
        let attributeString =  NSMutableAttributedString(string: tableCell.textLabel!.text!)
        if sender.checkState == .Checked{
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSMakeRange(0, attributeString.length))
        }else if sender.checkState == .Unchecked{
            attributeString.removeAttribute(NSStrikethroughStyleAttributeName, range: NSMakeRange(0, attributeString.length))
        }
        //alamofire send api request to update status
        
        //update self data strucutre
        
        
        tableCell.textLabel!.attributedText = attributeString
    }

}
