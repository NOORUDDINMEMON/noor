//
//  DetailViewController.swift
//  CollectionViewApp
//
//  Created by Nooruddin on 23/06/19.
//  Copyright © 2019 Nooruddin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selection: String!
    @IBOutlet private weak var detailsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailsLabel.text = selection
    }
    

    

}
