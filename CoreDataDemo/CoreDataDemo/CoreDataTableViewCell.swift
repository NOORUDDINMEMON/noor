//
//  CoreDataTableViewCell.swift
//  CoreDataDemo
//
//  Created by Nooruddin on 12/06/19.
//  Copyright © 2019 Nooruddin. All rights reserved.
//

import UIKit

class CoreDataTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    
    var student: Student! {
        didSet{
            lbl1.text = student.name
            lbl2.text = student.city
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
