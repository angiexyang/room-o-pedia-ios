//
//  ViewRoomViewController.swift
//  room-o-pedia-ios
//
//  Created by Angie X Yang on 2/15/22.
//

import UIKit

class ViewRoomViewController: UIViewController {
    
    var room: Room!
    
    @IBOutlet weak var roomImageView: UIImageView!
    
    @IBOutlet weak var DormRoomLabel: UILabel!
    
    //if user edits room, send room data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editRoomSegue" {
            let vc = segue.destination as! AddRoomViewController
            vc.room = room
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set label to selected room
        DormRoomLabel.text = room!.dorm + " " + room!.number
        
        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
