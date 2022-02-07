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
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    
    
    @IBAction func saveClick(_ sender: Any) {
        APIFunctions.functions.AddRoom(room: titleTextField.text!, number: bodyTextView.text)
        print("Saved")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
