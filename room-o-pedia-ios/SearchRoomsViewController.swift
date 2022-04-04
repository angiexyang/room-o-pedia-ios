//
//  SearchRoomsViewController.swift
//  room-o-pedia-ios
//
//  Created by Angie X Yang on 3/18/22.
//

import UIKit


class SearchRoomsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    var roomsArray = [Room]()
    var searchResultsArray = [Room]()
    var room: Room!
    
    var featureArray = [String]()
    var tagCount = 0
    var selectedNumber = 0
    
    @IBOutlet weak var numberSelect: UITextField!
    @IBOutlet weak var dormDropDown: UIPickerView!
    @IBOutlet weak var dormTextBox: UITextField!
    @IBOutlet weak var SearchButton: UIButton!
    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    
    @IBAction func getRoom() {
        selectedNumber = Int(numberSelect.text!) ?? 0
        print("CHECK SELECTION HERE " + selectedDorm + " " + String(selectedNumber))
        searchResultsArray = roomsArray.filter{$0.dorm == selectedDorm && Int($0.number) == selectedNumber}
        if searchResultsArray.count == 1 {
            print("FOUND IT")
            //assign global variable value of found room
            room = searchResultsArray[0]
            // GET PHOTOURLS
            let currURL = room.photoURL[0] // GET FIRST FOR TESTER
            let dormAndNumber = room.dorm + " " + room.number
            let dormAndNumber0 = dormAndNumber + "0"
            //let searchDormAndNumber = room.dorm + " " + room.number + "search" //not needed if only show first of each
            //roomImage.loadFrom(URLAddress: currURL)
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    if let cachedImage = Cache.imageCache.object(forKey: NSString(string: dormAndNumber0)) {
                        self.roomImage.image = cachedImage
                    } else {
                        let url = URL(string: currURL)
                        let data = try? Data(contentsOf: url!)
                        let image: UIImage = UIImage(data: data!)!
                        self.roomImage.image = image
                        Cache.imageCache.setObject(image, forKey: NSString(string: dormAndNumber0))
                    }
                    
                }
            }
            tagCollectionView.delegate = self
            tagCollectionView.dataSource = self
        }
        else if searchResultsArray.count > 1 {
            print("FOUND MORE THAN ONE")
        }
        else {
            print ("FOUND NONE")
            let alert = UIAlertController(title: "Room Not Found", message: "Try searching for a different dorm room.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) {_ in})
            self.present(alert, animated: true) {}
        }
        
        
    }
    
    var dormNames = ["Merion", "New Dorm", "Radnor"]
    var selectedDorm = "None"
    
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
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var tagTotal = 3 +  room.features.storage.count + room.features.window_direction.count
        if (!room.features.other.isEmpty && room.features.other[0] != ""){
            tagTotal = tagTotal + room.features.other.count
        }
        return tagTotal
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "featureTag", for: indexPath) as! TagCollectionViewCell
        cell.roomTagLabel.font = UIFont.systemFont(ofSize: 11)
        let coolingTag = room.features.cooling_system + " ac"
        
        featureArray = [room.features.floor + " floor", coolingTag, room.features.flooring + " floor"]
        
        for s in room.features.storage{
            featureArray.append(s)
        }
        
        for w in room.features.window_direction{
            featureArray.append(w + " windows")
        }
        
        for o in room.features.other{
            if (o != "") {
                featureArray.append(o)
            }
            
        }
        if tagCount<featureArray.count{
            cell.roomTagLabel.text = featureArray[tagCount]
        }
        tagCount+=1
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchRooms()
        print("roomsarray ", roomsArray.count)

        dormDropDown.selectedRow(inComponent: 0)
        numberSelect.placeholder = "Type Room Number"
        dormTextBox.placeholder = "Select a Dorm"
        
        
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


