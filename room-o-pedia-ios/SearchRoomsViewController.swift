//
//  SearchRoomsViewController.swift
//  room-o-pedia-ios
//
//  Created by Angie X Yang on 3/18/22.
//

import UIKit


class SearchRoomsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    


    var roomsArray = [Room]()
    var searchResultsArray = [Room]()
    
    @IBOutlet weak var numberSelect: UITextView!
    @IBOutlet weak var dormDropDown: UIPickerView!
    @IBOutlet weak var dormTextBox: UITextField!
    @IBOutlet weak var SearchButton: UIButton!
    
    @IBAction func getVal() {
        selectedNumber = Int(numberSelect.text) ?? 0
        print("CHECK SELECTION HERE " + selectedDorm + " " + String(selectedNumber))
        searchResultsArray = roomsArray.filter{$0.dorm == selectedDorm && Int($0.number) == selectedNumber}
        if searchResultsArray.count == 1 {
            print("FOUND IT")
        }
        else if searchResultsArray.count > 1 {
            print("FOUND MORE THAN ONE")
        }
        else {
            print ("FOUND NONE")
        }
        
    }
    
    var dormNames = ["Merion", "New Dorm", "Radnor"]
    var selectedDorm = "None"
    var selectedNumber = 0
    
    // function sets one field per filter
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    // function sets number of rows in filter picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        let countRows : Int = dormNames.count
        return countRows
        
        
    }
    
    // function that I don't really get the point of
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let titleRow = dormNames[row]
        return titleRow
        
       
    }
    
    // function that does the logic:
    // upon selecting a row, it displays the selected option, hides the dropdown picker, and populates the filteredRoomsArray
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.dormTextBox.text = self.dormNames[row]
        self.dormDropDown.isHidden = true
        self.selectedDorm = self.dormNames[row]
       // self.getVal()
    }
    
    // function that does formating
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "SanFranciscoText-Light", size: 18)

        label.text = dormNames[row]

        return label
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.dormDropDown.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchRooms()
        print(roomsArray)

        
        dormDropDown.selectedRow(inComponent: 0)
        dormTextBox.text = "Select Dorm"
        numberSelect.text = "Type Room Number"
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

extension SearchRoomsViewController: DataDelegate {
    func updateArray(newArray: String) {
        do {
            roomsArray = try JSONDecoder().decode([Room].self, from: newArray.data(using: .utf8)!)
        } catch {
            print("Failed to decode")
        }
        print("ROOMS COUNT " + String(self.roomsArray.count))
    }
    
}
