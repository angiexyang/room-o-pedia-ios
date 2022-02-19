//
//  RoomTableViewCell.swift
//  room-o-pedia-ios
//
//  Created by Angie X Yang on 2/19/22.
//

import UIKit

class RoomTableViewCell: UITableViewCell {

    @IBOutlet var roomLabel: UILabel!
    @IBOutlet var roomPreviewImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
