//
//  FavoriteTableViewCell.swift
//  room-o-pedia-ios
//
//  Created by Angie X Yang on 3/24/22.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favLabel: UILabel!
    @IBOutlet weak var favNote: UITextField!
    @IBOutlet weak var nextSign: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
