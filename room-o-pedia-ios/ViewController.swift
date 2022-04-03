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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPopoverPresentationControllerDelegate {
    
    
    // ------- Room Feature Filters --------------------------------------------------------------
    
    @IBOutlet weak var addFiltersButton: UIButton!
    @IBOutlet weak var roomsDisplayed: UITextView!
    @IBOutlet weak var filtersApplied: UITextView!
    @IBAction func addFilters() {
        //print(currentFilters)
    }
    
    
    // use this array for rooms that apply to the current filters
    var filteredRoomsArray = [Room]()
    
    // use these to keep track of there are ANY filters active, and what they're set to
    var filterActive = false
    
    // NEW!! USE THIS STRING ARRAY
    var currentFilters = [String]()
    var currentRooms = [Room]()
    var roomsDisplayedNumber = 0;
    
    var tagClicked = false
    
    //------------------------------------ FILTERING LOGIC ---------------------------
    func filterRooms() {
        if currentFilters.count > 0 {
            filterActive = true
            print("currFilter \n", currentFilters)
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
            
            currentRooms.removeAll(where: {unselectedDorms.contains($0.dorm)})
        }
        
        
        // check other conditions for the rest of the rooms
        for room in currentRooms {
            do {
                roomFeatureDict = try DictionaryEncoder().encode(room.features)
            } catch {
            }
            
            // go through each category that requires filtering
            for keyFilter in selectedKeys {
                if roomFeatureDict[keyFilter] != nil {
                    if let accessDict = roomFeatureDict[keyFilter]! as? String {
                        roomValues = Array(arrayLiteral: accessDict)
                    } else if let accessDict = roomFeatureDict[keyFilter]! as? [String] {
                        roomValues = accessDict
                    }
                } else {
                    roomValues = []
                }
                selectedValues = currFiltersDict[keyFilter]!
                
                for option in selectedValues {
                    if roomValues.contains(option) {
                        satisfied = true
                        break
                    } else {
                        satisfied = false
                    }
                }
                if satisfied == false {
                    let indexRoom = currentRooms.firstIndex(where: {$0.dorm + $0.number == room.dorm + room.number})
                    currentRooms.remove(at: indexRoom!)
                    break
                }
            }
        }
        
        filteredRoomsArray = currentRooms
        filteredRoomsArray.sort{$0.dorm + " " + $0.number < $1.dorm + " " + $1.number}
        print("FOUND \(filteredRoomsArray.count) RESULTS!!!!!!")
    }
    //------------------------------------ END MAIN FILTER --------------------------
    
    
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
        }
    }
    
    //function to reload view controller, called in both unwind functions
    func reloadVC(){
        if (currentFilters.count > 0) {
            filterRooms()
            print("------------JUST RELOADED MAIN VIEW-------------")
        } else {
            print("FILTER IS NOT ACTIVE")
            filteredRoomsArray = roomsArray
        }
        
        // Counts for filters applied and rooms found
        roomsDisplayedNumber = filteredRoomsArray.count
        if (roomsDisplayedNumber == 0){
            roomsDisplayed.text = String(roomsDisplayedNumber) + " Rooms Found"
        }
        else if (roomsDisplayedNumber == 1){
            roomsDisplayed.text = String(roomsDisplayedNumber) + " Room Found"
        }
        else {
            roomsDisplayed.text = String(roomsDisplayedNumber) + " Rooms Found"
        }
        
        if (currentFilters.count == 1) {
            filtersApplied.text = String(currentFilters.count) + " Filter Applied"
        }
        else {
            filtersApplied.text = String(currentFilters.count) + " Filters Applied"
        }
        
        self.roomsTableView.reloadData()
    }
    
    //unwind from filter screen
    @IBAction func unwind(_ seg: UIStoryboardSegue) {
        reloadVC()
    }

    //unwind from single room view after tag is clicked
    @IBAction func tagClickUnwind( _ seg: UIStoryboardSegue){
        print("tagClickUnwind")
        print("currfilters passed: \t",currentFilters)
        reloadVC()
        
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
            //index path is which cell is clicked on
            let currRoom = filteredRoomsArray[indexPath.row]
            let dormAndNumber = currRoom.dorm + " " + currRoom.number
            cell.roomLabel.text = dormAndNumber
            cell.occupancyLabel.text = currRoom.features.occupancy + " occupancy"
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
            let currRoom = roomsArray[indexPath.row]
            let dormAndNumber = currRoom.dorm + " " + currRoom.number
            cell.roomLabel.text = dormAndNumber
            cell.occupancyLabel.text = currRoom.features.occupancy + " occupancy"
            cell.roomPreviewImageView.loadFrom(URLAddress: currRoom.photoURL[0])
            
            
            // ----------------------- starButton 2 ----------------------
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
            
            roomsDisplayedNumber = roomsArray.count
            roomsDisplayed.text = String(roomsDisplayedNumber) + " Rooms Found"
            filtersApplied.text = String(currentFilters.count) + " Filters Applied"
            // --------------- End star button 2------------------------------------
            return cell
        }
        
        
    }
    
    
        
    @IBOutlet weak var roomsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchRooms()
       
        
        roomsTableView.delegate = self
        roomsTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        
        roomsDisplayed.isEditable = false
        roomsDisplayed.isSelectable = false
        
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
