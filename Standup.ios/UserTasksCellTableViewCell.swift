//
//  UserTasksCellTableViewCell.swift
//  Standup.ios
//
//  Created by julien on 6/8/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit

class UserTasksCellTableViewCell: UITableViewCell, CellConfigurable {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tasks: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func configWithData(data: AnyObject){
        if let data = data as? ParsedUser{
            self.avatar.sd_setImageWithURL(NSURL.init(string: "http://localhost:3000\(data.avatar)"), placeholderImage: nil)
            self.name.text = data.user_name
            
//            let tasksDataSource = ArrayDataSource(tableView: tasks, nibName: "TaskCell", cellIdentifier: "TaskCell")
//            tasksDataSource.data = data.tasks
//            tasks.dataSource = tasksDataSource
        }
    }
    
}
