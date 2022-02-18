//
//  RoomTableViewCell.swift
//  room-o-pedia-ios
//
//  Created by Angie X Yang on 2/17/22.
//

import UIKit

class RoomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var RoomTitleLabel: UILabel!
    @IBOutlet weak var RoomPreviewImageView: UIImageView?
    @IBOutlet weak var RoomTagsCollectionView: UICollectionView?
   

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
