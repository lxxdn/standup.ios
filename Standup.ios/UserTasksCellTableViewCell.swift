//
//  UserTasksCellTableViewCell.swift
//  Standup.ios
//
//  Created by julien on 6/8/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit

class UserTasksCellTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configWithData(data: ParsedTask ){
        
        self.avatar.sd_setImageWithURL(NSURL.init(string: "http://hello"), placeholderImage: nil)
    }
    
}
