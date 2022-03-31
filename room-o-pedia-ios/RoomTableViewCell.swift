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
    @IBOutlet weak var occupancyLabel: UILabel!
    
    // Adding star button test
    @IBOutlet var starButton: UIButton!
    var favButtonPressed : (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // test star
       /* starButton.setImage(UIImage(systemName: "star"), for: .normal)
        starButton.setImage(UIImage(systemName: "star.fill"), for: .selected) */
    }
    
    @IBAction func clickFav(_ sender: UIButton) {
/*        if starButton.isSelected {
            starButton.isSelected = false
        } else {
            starButton.isSelected = true
        }      */
        favButtonPressed()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
