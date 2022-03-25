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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIPopoverPresentationControllerDelegate {
    
    // ------- Room Feature Filters --------------------------------------------------------------
    
    @IBOutlet weak var addFiltersButton: UIButton!
    @IBOutlet weak var dropDownFloors: UIPickerView!
    @IBOutlet weak var textBoxFloors: UITextField!
    @IBOutlet weak var dropDownAC: UIPickerView!
    @IBOutlet weak var textBoxAC: UITextField!
    
    @IBAction func addFilters() {
        
        /* 2 */
        //Configure the presentation controller
        let popoverContentController = self.storyboard?.instantiateViewController( withIdentifier: "PopoverContentController") as? PopoverContentController
        popoverContentController?.modalPresentationStyle = .popover

        /* 3 */
        if let popoverPresentationController = popoverContentController?.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .unknown
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect.zero
            popoverPresentationController.delegate = self
            if let popoverController = popoverContentController {
                present(popoverController, animated: true, completion: nil)
            }
        }
    }
    
    //UIPopoverPresentationControllerDelegate inherits from UIAdaptivePresentationControllerDelegate, we will use this method to define the presentation style for popover presentation controller
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {

    }

    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
    // arrays of options for each filter
    var floorsFeature = ["Any Floor", "1st", "2nd", "3rd", "4th"]
    var ACFeature = ["Any AC Option", "central", "window unit", "none"]
    
    // use this array for rooms that apply to the current filters
    var filteredRoomsArray = [Room]()
    
    // use these to keep track of there are ANY filters active, and what they're set to
    var filterActive = false
    var floorsCurrFilter = "None"
    var ACCurrFilter = "None"
    
    // function sets one field per filter
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // function sets number of rows in filter picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows : Int = ACFeature.count
        if pickerView == dropDownFloors {
            countRows = self.floorsFeature.count
        }
        return countRows
    }
    
    // function that I don't really get the point of
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
    
    // function that does the logic:
    // upon selecting a row, it displays the selected option, hides the dropdown picker, and populates the filteredRoomsArray
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
    
    // function that does formating
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "SanFranciscoText-Light", size: 18)
        
        if (pickerView == dropDownFloors) {
            label.text = floorsFeature[row]
        }
        else {
            label.text = ACFeature[row]
        }
        return label
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
            if (filterActive) {
                vc.room = filteredRoomsArray[roomsTableView.indexPathForSelectedRow!.row]
            }
            else {
                vc.room = roomsArray[roomsTableView.indexPathForSelectedRow!.row]
            }
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
    
    
    // empty UserDefaults array
    var rowsWhichAreChecked = UserDefaults.standard.array(forKey: "roomFavorite") as? [String] ?? [String] ()
    
    //customize what is displayed inside cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "RoomCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RoomTableViewCell
        // if there are any filters applied, the table will dequeue rooms from the filteredRoomsArray
        if (filterActive) {
            //filteredRoomsArray.sort{$0.dorm + " " + $0.number < $1.dorm + " " + $1.number}
            //index path is which cell is clicked on
            let currRoom = filteredRoomsArray[indexPath.row]
            let dormAndNumber = currRoom.dorm + " " + currRoom.number
    //        cell.imageView?.image = UIImage(named: "rad101")
    //        cell.textLabel?.text = dormAndNumber
            cell.roomLabel.text = dormAndNumber
            cell.roomPreviewImageView.loadFrom(URLAddress: currRoom.photoURL[0])
            
            //------------------- starButton ---------------
            if rowsWhichAreChecked.contains(dormAndNumber) {
                cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
            
            cell.favButtonPressed = { [ weak self ] in
                if self!.rowsWhichAreChecked.contains(dormAndNumber) {
                    let removeFav = self?.rowsWhichAreChecked.lastIndex(where: {$0 == dormAndNumber})
                    self!.rowsWhichAreChecked.remove(at: removeFav!)
                    
                    cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
                } else {
                    cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    self!.rowsWhichAreChecked.append(dormAndNumber)
                }
                UserDefaults.standard.set(self!.rowsWhichAreChecked, forKey: "roomFavorite")
                print("ROOMS CHECKED: ")
                print(self!.rowsWhichAreChecked)
                
                //self?.roomsTableView.reloadData()
            }
            // ---------------------------------------------
            return cell
        }
        // if no filters applied, then use the full roomsArray
        else {
            //roomsArray.sort{$0.dorm + " " + $0.number < $1.dorm + " " + $1.number}
            let currRoom = roomsArray[indexPath.row]
            let dormAndNumber = currRoom.dorm + " " + currRoom.number
    //        cell.imageView?.image = UIImage(named: "rad101")
    //        cell.textLabel?.text = dormAndNumber
            cell.roomLabel.text = dormAndNumber
            cell.roomPreviewImageView.loadFrom(URLAddress: currRoom.photoURL[0])
            
            
            // ----------------------- test starButton ----------------------
            if rowsWhichAreChecked.contains(dormAndNumber) {
                cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
            
            cell.favButtonPressed = { [ weak self ] in
                if self!.rowsWhichAreChecked.contains(dormAndNumber) {
                    let removeFav = self?.rowsWhichAreChecked.lastIndex(where: {$0 == dormAndNumber})
                    self!.rowsWhichAreChecked.remove(at: removeFav!)
                    
                    cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
                } else {
                    cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    self!.rowsWhichAreChecked.append(dormAndNumber)
                }
                UserDefaults.standard.set(self!.rowsWhichAreChecked, forKey: "roomFavorite")
                print("ROOMS CHECKED: ")
                print(self!.rowsWhichAreChecked)
                
                //self?.roomsTableView.reloadData()
            }
            // --------------- End test star button ------------------------------------
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
        textBoxFloors.placeholder = "Select Floor"
        textBoxAC.placeholder = "Select AC Option"
    }
}

extension ViewController: DataDelegate {
    func updateArray(newArray: String) {
        do {
            roomsArray = try JSONDecoder().decode([Room].self, from: newArray.data(using: .utf8)!)
            roomsArray.sort{$0.dorm + " " + $0.number < $1.dorm + " " + $1.number}
        } catch {
            print("Failed to decode")
        }
        self.roomsTableView?.reloadData()
    }
    
}
