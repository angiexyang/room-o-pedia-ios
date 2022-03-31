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
    @IBOutlet weak var roomsCount: UILabel!
    
    @IBAction func addFilters() {
        print(currentFilters)
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
    
    // NEW!! USE THIS STRING ARRAY
    var currentFilters = [String]()
    var currentRooms = [Room]()
    
    //------------------------------------ FILTERING LOGIC TEST ---------------------------
    func filterRooms() {
        //print("GOT INTO FUNCTION")
        if currentFilters.count > 0 {
            filterActive = true
          //  print("FILTER TURNED ON")
        }
        
        var currFiltersDict = [String : [String]]()
        
        for filter in currentFilters {
            if let index = filter.firstIndex(of: "-") {
                let category = String(filter.prefix(upTo: index))
                let option = String(String(filter.suffix(from: index)).dropFirst())
                
                if currFiltersDict[category] != nil {
                    currFiltersDict[category]!.append(option)
                } else {
                    currFiltersDict[category] = [option]
                }
            }
        }
       // print("CURRENT FILTER DICT")
       // print(currFiltersDict)
        
        currentRooms = roomsArray
        
        var roomFeatureDict = [String : Any]()
        var selectedKeys = Array(currFiltersDict.keys)
        var selectedValues = [String]()
        var roomValues = [String]()
        let dormList = ["Radnor", "Merion", "New Dorm"]
        var unselectedDorms = [String]()
        var satisfied = false
        
        // take out all rooms with the wrong dorm first
        if selectedKeys.contains("dorm") {
            for dorm in dormList {
                if !(currFiltersDict["dorm"]!.contains(dorm)) {
                    unselectedDorms.append(dorm)
                }
            }
            let indexDorm = selectedKeys.firstIndex(of: "dorm")
            selectedKeys.remove(at: indexDorm!)
            
          //  print("UNSELECTED DORMS")
          //  print(unselectedDorms)
            currentRooms.removeAll(where: {unselectedDorms.contains($0.dorm)})
        }
        
        
        // check other conditions for the rest of the rooms
        for room in currentRooms {
           // print("//////////// \(room.dorm) \(room.number)  //////////////")
            do {
                roomFeatureDict = try DictionaryEncoder().encode(room.features)
            } catch {
           //     print("FAILED TO CONVERT TO DICT")
            }
            
            // go through each category that requires filtering
            for keyFilter in selectedKeys {
             //   print("ROOM DICT AT KEY LOOKS LIKE")
             //   print(roomFeatureDict[keyFilter]!)
                if roomFeatureDict[keyFilter] != nil {
                    if let accessDict = roomFeatureDict[keyFilter]! as? String {
                        roomValues = Array(arrayLiteral: accessDict)
                    } else if let accessDict = roomFeatureDict[keyFilter]! as? [String] {
                        roomValues = accessDict
                    }
               //     print("ROOM VALUES ARRAY")
               //     print(roomValues)
                } else {
                    roomValues = []
                }
              //  print("FILTER SELECTED")
                selectedValues = currFiltersDict[keyFilter]!                    //"carpet"
              //  print(selectedValues)
                
                for option in selectedValues {                                  //"carpet"
                    if roomValues.contains(option) {
                        satisfied = true
                        break
                    } else {
                        satisfied = false                                       //false
                    }
                }
                
                if satisfied == false {
                    let indexRoom = currentRooms.firstIndex(where: {$0.dorm + $0.number == room.dorm + room.number})
                    currentRooms.remove(at: indexRoom!)
                    break
                }
            }
            //if satisfied == true {
            //    filteredRoomsArray.append(room)
            //}
        }
        
        filteredRoomsArray = currentRooms
        filteredRoomsArray.sort{$0.dorm + " " + $0.number < $1.dorm + " " + $1.number}
        print("FOUND \(filteredRoomsArray.count) RESULTS!!!!!!")
        roomsCount.text = "\(filteredRoomsArray.count) rooms found"
    }
        
        
    
    
    
    
    //------------------------------------ END MAIN FILTER TEST --------------------------
    
    
    
    
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
        else if segue.identifier == "applyFiltersSegue" {
            let vc = segue.destination as! ApplyFiltersViewController
            vc.currentFilters = self.currentFilters
      //      print("VIEW CONTROLLER CHECK HERE")
      //      print(self.currentFilters)
            
        }
        //dont need to send room info if new room
       // if segue.identifier == "roomsAddRoomSegue" {
          //  let vc = segue.destination as! AddRoomViewController
          //  vc.room = roomsArray[roomsTableView.indexPathForSelectedRow!.row]
       // }
        
    }
    
    @IBAction func unwind(_ seg: UIStoryboardSegue) {
        if (currentFilters.count > 0) {
            filterRooms()
            self.roomsTableView.reloadData()
            filteredRoomsArray = roomsArray
            print("------------JUST RELOADED MAIN VIEW-------------")
        } else {
            print("FILTER IS NOT ACTIVE")
            self.roomsTableView.reloadData()
        }
        //self.roomsTableView.reloadData()
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
    var starredRooms = [Room]()
    
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
                if !(starredRooms.contains(where: {$0.dorm + " " + $0.number == dormAndNumber})) {
                    starredRooms.append(currRoom)
                }
            } else {
                cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
                if starredRooms.contains(where: {$0.dorm + " " + $0.number == dormAndNumber}) {
                    let roomOffset = starredRooms.lastIndex(where: {$0.dorm + " " + $0.number == dormAndNumber})
                    starredRooms.remove(at: roomOffset!)
                }
            }
            
            cell.favButtonPressed = { [ weak self ] in
                if self!.rowsWhichAreChecked.contains(dormAndNumber) && self!.starredRooms.contains(where: {$0.dorm + " " + $0.number == dormAndNumber}) {
                    
                    // remove from list of starred rooms
                    let roomOffset = self!.starredRooms.lastIndex(where: {$0.dorm + " " + $0.number == dormAndNumber})
                    self!.starredRooms.remove(at: roomOffset!)
                    
                    //remove from list of text
                    let removeFav = self?.rowsWhichAreChecked.lastIndex(where: {$0 == dormAndNumber})
                    self!.rowsWhichAreChecked.remove(at: removeFav!)
                    
                    cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
                } else {
                    cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    self!.rowsWhichAreChecked.append(dormAndNumber)
                    if !(self!.starredRooms.contains(where: {$0.dorm + " " + $0.number == dormAndNumber})) {
                        self!.starredRooms.append(currRoom)
                    }
                }
                
                UserDefaults.standard.set(self!.rowsWhichAreChecked, forKey: "roomFavorite")
                if let dataRoom = try? PropertyListEncoder().encode(self!.starredRooms) {
                    UserDefaults.standard.set(dataRoom, forKey: "starredRooms")
                }
               
                print("ROOMS CHECKED: ")
                print(self!.rowsWhichAreChecked)
                
                print("STARRED ROOM OBJECTS: ")
                let defaults = UserDefaults.standard
                if let data = defaults.data(forKey: "starredRooms") {
                    let finalArray = try! PropertyListDecoder().decode([Room].self, from: data)
                    for roomElem in finalArray {print(roomElem)}
                }
                
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
                if !(starredRooms.contains(where: {$0.dorm + " " + $0.number == dormAndNumber})) {
                    starredRooms.append(currRoom)
                }
            } else {
                cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
                if starredRooms.contains(where: {$0.dorm + " " + $0.number == dormAndNumber}) {
                    let roomOffset = starredRooms.lastIndex(where: {$0.dorm + " " + $0.number == dormAndNumber})
                    starredRooms.remove(at: roomOffset!)
                }
            }
            
            cell.favButtonPressed = { [ weak self ] in
                if self!.rowsWhichAreChecked.contains(dormAndNumber) && self!.starredRooms.contains(where: {$0.dorm + " " + $0.number == dormAndNumber}) {
                    
                    // remove from list of starred rooms
                    let roomOffset = self!.starredRooms.lastIndex(where: {$0.dorm + " " + $0.number == dormAndNumber})
                    self!.starredRooms.remove(at: roomOffset!)
                    
                    //remove from list of text
                    let removeFav = self?.rowsWhichAreChecked.lastIndex(where: {$0 == dormAndNumber})
                    self!.rowsWhichAreChecked.remove(at: removeFav!)
                    
                    cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
                } else {
                    cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    self!.rowsWhichAreChecked.append(dormAndNumber)
                    if !(self!.starredRooms.contains(where: {$0.dorm + " " + $0.number == dormAndNumber})) {
                        self!.starredRooms.append(currRoom)
                    }
                }
                
                UserDefaults.standard.set(self!.rowsWhichAreChecked, forKey: "roomFavorite")
                if let dataRoom = try? PropertyListEncoder().encode(self!.starredRooms) {
                    UserDefaults.standard.set(dataRoom, forKey: "starredRooms")
                }
               
                print("ROOMS CHECKED: ")
                print(self!.rowsWhichAreChecked)
                
                print("STARRED ROOM OBJECTS: ")
                let defaults = UserDefaults.standard
                if let data = defaults.data(forKey: "starredRooms") {
                    let finalArray = try! PropertyListDecoder().decode([Room].self, from: data)
                    for roomElem in finalArray {print(roomElem)}
                }
                
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






// ------------- OBJECT TO DICT -----------------
class DictionaryEncoder {

    private let encoder = JSONEncoder()

    var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy {
        set { encoder.dateEncodingStrategy = newValue }
        get { return encoder.dateEncodingStrategy }
    }

    var dataEncodingStrategy: JSONEncoder.DataEncodingStrategy {
        set { encoder.dataEncodingStrategy = newValue }
        get { return encoder.dataEncodingStrategy }
    }

    var nonConformingFloatEncodingStrategy: JSONEncoder.NonConformingFloatEncodingStrategy {
        set { encoder.nonConformingFloatEncodingStrategy = newValue }
        get { return encoder.nonConformingFloatEncodingStrategy }
    }

    var keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy {
        set { encoder.keyEncodingStrategy = newValue }
        get { return encoder.keyEncodingStrategy }
    }

    func encode<T>(_ value: T) throws -> [String: Any] where T : Encodable {
        let data = try encoder.encode(value)
        return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
    }
}
