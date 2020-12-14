//
//  To-Do-ListCell.swift
//  DemoProject
//
//  Created by Subhangi Pawar on 14/12/20.
//

import UIKit

class To_Do_ListCell: UITableViewCell {

    @IBOutlet weak var lblTaskName: UILabel!
    @IBOutlet weak var lblTaskTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
