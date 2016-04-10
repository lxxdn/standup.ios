//
//  NewTaskView.swift
//  Standup.ios
//
//  Created by julien on 3/14/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit
import Alamofire

class TaskFormView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var projectBtn: UIButton!
    @IBOutlet weak var userBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var taskContentInput: UITextView!
    let selectView = UITableView()
    let tableCellIdentifier = "selectCell"
    
    var data = [NSDictionary](){
        didSet{
            selectView.reloadData()
        }
    }//id and name tuple
    

    
    func tapViewAction(recognizer: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        taskContentInput.text = ""
        taskContentInput.placeholder = "Input your content"
        taskContentInput.becomeFirstResponder()
        
        selectView.frame.size = UIScreen.mainScreen().bounds.size
        selectView.frame.origin.y = UIScreen.mainScreen().bounds.height
        self.addSubview(selectView)
        
        // set font icon
        let fa = UIFont(name: kFontAwesomeFamilyName, size: 20)
        projectLabel.font = fa
        projectLabel.text = NSString.fontAwesomeIconStringForEnum(.FACog)
        userLabel.font = fa
        userLabel.text = NSString.fontAwesomeIconStringForEnum(.FAUser)
        
        // add gesture recognizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(TaskFormView.tapViewAction(_:)))
        self.mainView.addGestureRecognizer(tapRecognizer)
    }
    
}
