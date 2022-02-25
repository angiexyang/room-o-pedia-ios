//
//  ViewController.swift
//  room-o-pedia-ios
//
//  Created by Angie X Yang on 2/4/22.
//

import UIKit

protocol DataDelegate {
    func updateArray(newArray: String)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
   
    var filterActive = false
    var floorsCurrFilter = "None"
    var ACCurrFilter = "None"
    
    // ------- Room Feature Filters --------------------------------------------------------------
    
    @IBOutlet weak var dropDownFloors: UIPickerView!
    @IBOutlet weak var textBoxFloors: UITextField!
    @IBOutlet weak var dropDownAC: UIPickerView!
    @IBOutlet weak var textBoxAC: UITextField!
    
    var floorsFeature = ["Any Floor", "1st", "2nd", "3rd", "4th"]
    var ACFeature = ["Any AC Option", "central", "window unit", "none"]
    
    var filteredRoomsArray = [Room]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows : Int = ACFeature.count
        if pickerView == dropDownFloors {
            countRows = self.floorsFeature.count
        }
        return countRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == dropDownAC {
            let titleRow = ACFeature[row]
            return titleRow
        }
        else if pickerView == dropDownFloors {
            let titleRow = floorsFeature[row]
            return titleRow
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == dropDownAC {
            filteredRoomsArray = roomsArray
            self.textBoxAC.text = self.ACFeature[row]
            self.dropDownAC.isHidden = true
            
            ACCurrFilter = self.ACFeature[row]
            filteredRoomsArray = roomsArray.filter{$0.features.cooling_system == ACCurrFilter || ACCurrFilter == "Any AC Option"}
        }
        else if pickerView == dropDownFloors {
            filteredRoomsArray = roomsArray
            self.textBoxFloors.text = self.floorsFeature[row]
            self.dropDownFloors.isHidden = true
            
            floorsCurrFilter = self.floorsFeature[row]
            filteredRoomsArray = roomsArray.filter{$0.features.floor == floorsCurrFilter || floorsCurrFilter == "Any Floor"}
        }
        filterActive = true
        self.roomsTableView.reloadData()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == self.textBoxAC) {
            self.dropDownAC.isHidden = false
        }
        else if (textField == self.textBoxFloors) {
            self.dropDownFloors.isHidden = false
        }
    }
    
    // ------- Room Listings -------------------------------------------------------------
    var roomsArray = [Room]()
    
    //want update room segue to change to view room segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "viewRoomSegue" {
            let vc = segue.destination as! ViewRoomViewController
            vc.room = roomsArray[roomsTableView.indexPathForSelectedRow!.row]
            //passing data
        }
        //dont need to send room info if new room
       // if segue.identifier == "roomsAddRoomSegue" {
          //  let vc = segue.destination as! AddRoomViewController
          //  vc.room = roomsArray[roomsTableView.indexPathForSelectedRow!.row]
       // }
        
    }
    //returns number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (filterActive) {
            return filteredRoomsArray.count
        }
        return roomsArray.count
    }
    
    //customize what is displayed inside cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "RoomCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RoomTableViewCell
        if (filterActive) {
            let currRoom = filteredRoomsArray[indexPath.row]
            let dormAndNumber = currRoom.dorm + " " + currRoom.number
    //        cell.imageView?.image = UIImage(named: "rad101")
    //        cell.textLabel?.text = dormAndNumber
            cell.roomLabel.text = dormAndNumber
            cell.roomPreviewImageView.image = UIImage(named: "rad101")
            print(currRoom.features)
            return cell
        }
        else {
        //index path is which cell is clicked on
        let currRoom = roomsArray[indexPath.row]
        let dormAndNumber = currRoom.dorm + " " + currRoom.number
//        cell.imageView?.image = UIImage(named: "rad101")
//        cell.textLabel?.text = dormAndNumber
        cell.roomLabel.text = dormAndNumber
        cell.roomPreviewImageView.image = UIImage(named: "rad101")
        print(currRoom.features)
        return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
    
    @IBOutlet weak var roomsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchRooms()
       // print(roomsArray)
        
        roomsTableView.delegate = self
        roomsTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        dropDownFloors.selectedRow(inComponent: 0)
        dropDownAC.selectedRow(inComponent: 0)
        textBoxFloors.text = "Select Floor"
        textBoxAC.text = "Select AC Option"
    }


}

extension ViewController: DataDelegate {
    func updateArray(newArray: String) {
        do {
            roomsArray = try JSONDecoder().decode([Room].self, from: newArray.data(using: .utf8)!)
        } catch {
            print("Failed to decode")
        }
        self.roomsTableView?.reloadData()
    }
    
}
