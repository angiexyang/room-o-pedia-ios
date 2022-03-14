//
//  TagCollectionViewCell.swift
//  room-o-pedia-ios
//
//  Created by Angie X Yang on 2/22/22.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var roomTagLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 20.0
        layer.masksToBounds = false
    }
}
