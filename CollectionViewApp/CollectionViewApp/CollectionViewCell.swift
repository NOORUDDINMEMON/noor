//
//  CollectionViewCell.swift
//  CollectionViewApp
//
//  Created by Nooruddin on 23/06/19.
//  Copyright © 2019 Nooruddin. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet private weak var selectionImage: UIImageView!
    @IBOutlet private weak var mainImage: UIImageView!
    
    var isEditing: Bool = false {
        didSet {
            selectionImage.isHidden = !isEditing
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isEditing {
                selectionImage.image = isSelected ? UIImage(named: "Checked") : UIImage(named: "Unchecked")
            }
        }
    }
    
    
}
