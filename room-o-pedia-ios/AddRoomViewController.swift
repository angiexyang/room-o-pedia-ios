//
//  AddRoomViewController.swift
//  room-o-pedia-ios
//
//  Created by Angie X Yang on 2/7/22.
//

import UIKit

class AddRoomViewController: UIViewController {
    
    var room: Room?

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var dormTextField: UITextField!
    
    @IBOutlet weak var roomNumTextField: UITextField!
    
    
    
    @IBAction func saveClick(_ sender: Any) {
        APIFunctions.functions.AddRoom(dorm: dormTextField.text!, number: roomNumTextField.text!)
        print("Saved")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //if a room is sent, fill in text fields with data
        if room != nil {
            dormTextField.text = room!.dorm
            roomNumTextField.text = room!.number
        }
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
