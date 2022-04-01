//
//  ApplyFiltersViewController.swift
//  room-o-pedia-ios
//
//  Created by Rachel H Lee on 3/28/22.
//

import UIKit

class ApplyFiltersViewController: UIViewController {

    var currentFilters = [String]()
    
    
    @IBOutlet weak var floorTextLabel: UITextView!
    @IBOutlet weak var dormTextLabel: UITextView!
    @IBOutlet weak var occupancyTextLabel: UITextView!
    @IBOutlet weak var acTextLabel: UITextView!
    @IBOutlet weak var flooringTextLabel: UITextView!
    @IBOutlet weak var storageTextLabel: UITextView!
    @IBOutlet weak var windowTextLabel: UITextView!
    @IBOutlet weak var otherTextLabel: UITextView!
    
    @IBOutlet weak var floor1st: UIButton!
    @IBOutlet weak var floor2nd: UIButton!
    @IBOutlet weak var floor3rd: UIButton!
    @IBOutlet weak var floor4th: UIButton!
    @IBOutlet weak var dormMerion: UIButton!
    @IBOutlet weak var dormNewDorm: UIButton!
    @IBOutlet weak var dormRadnor: UIButton!
    @IBOutlet weak var occupancySingle: UIButton!
    @IBOutlet weak var occupancyDouble: UIButton!
    @IBOutlet weak var occupancyTriple: UIButton!
    @IBOutlet weak var acCentral: UIButton!
    @IBOutlet weak var acWindow: UIButton!
    @IBOutlet weak var flooringWood: UIButton!
    @IBOutlet weak var flooringCarpet: UIButton!
    @IBOutlet weak var storageCloset: UIButton!
    @IBOutlet weak var storageWardrobe: UIButton!
    @IBOutlet weak var storageDresser: UIButton!
    @IBOutlet weak var storageCaptains: UIButton!
    @IBOutlet weak var windowN: UIButton!
    @IBOutlet weak var windowNE: UIButton!
    @IBOutlet weak var windowE: UIButton!
    @IBOutlet weak var windowSE: UIButton!
    @IBOutlet weak var windowS: UIButton!
    @IBOutlet weak var windowSW: UIButton!
    @IBOutlet weak var windowW: UIButton!
    @IBOutlet weak var windowNW: UIButton!
    @IBOutlet weak var otherFireplace: UIButton!
    @IBOutlet weak var otherWindowSeat: UIButton!
    
    @IBOutlet weak var testDone: UIButton!
    @IBOutlet weak var clearFilters: UIButton!
    
    @IBAction func tappedFloor1st() {
        if floor1st.isSelected == true {
            floor1st.isSelected = false
            floor1st.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "floor-1st"}
        }
        else {
            floor1st.isSelected = true
            floor1st.tintColor = UIColor.systemBlue
            currentFilters.append("floor-1st")
        }
    }
    
    @IBAction func tappedFloor2nd() {
        if floor2nd.isSelected == true {
            floor2nd.isSelected = false
            floor2nd.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "floor-2nd"}
        }
        else {
            floor2nd.isSelected = true
            floor2nd.tintColor = UIColor.systemBlue
            currentFilters.append("floor-2nd")
        }
    }
    
    @IBAction func tappedFloor3rd() {
        if floor3rd.isSelected == true {
            floor3rd.isSelected = false
            floor3rd.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "floor-3rd"}
        }
        else {
            floor3rd.isSelected = true
            floor3rd.tintColor = UIColor.systemBlue
            currentFilters.append("floor-3rd")
        }
    }
    
    @IBAction func tappedFloor4th() {
        if floor4th.isSelected == true {
            floor4th.isSelected = false
            floor4th.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "floor-4th"}
        }
        else {
            floor4th.isSelected = true
            floor4th.tintColor = UIColor.systemBlue
            currentFilters.append("floor-4th")
        }
    }
    
    @IBAction func tappedDormMerion() {
        if dormMerion.isSelected == true {
            dormMerion.isSelected = false
            dormMerion.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "dorm-Merion"}
        }
        else {
            dormMerion.isSelected = true
            dormMerion.tintColor = UIColor.systemBlue
            currentFilters.append("dorm-Merion")
        }
    }
    
    @IBAction func tappedDormNewDorm() {
        if dormNewDorm.isSelected == true {
            dormNewDorm.isSelected = false
            dormNewDorm.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "dorm-New Dorm"}
        }
        else {
            dormNewDorm.isSelected = true
            dormNewDorm.tintColor = UIColor.systemBlue
            currentFilters.append("dorm-New Dorm")
        }
    }
    
    @IBAction func tappedDormRadnor() {
        if dormRadnor.isSelected == true {
            dormRadnor.isSelected = false
            dormRadnor.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "dorm-Radnor"}
        }
        else {
            dormRadnor.isSelected = true
            dormRadnor.tintColor = UIColor.systemBlue
            currentFilters.append("dorm-Radnor")
        }
    }
    
    @IBAction func tappedOccupancySingle() {
        if occupancySingle.isSelected == true {
            occupancySingle.isSelected = false
            occupancySingle.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "occupancy-single"}
        }
        else {
            occupancySingle.isSelected = true
            occupancySingle.tintColor = UIColor.systemBlue
            currentFilters.append("occupancy-single")
        }
    }
    
    @IBAction func tappedOccupancyDouble() {
        if occupancyDouble.isSelected == true {
            occupancyDouble.isSelected = false
            occupancyDouble.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "occupancy-double"}
        }
        else {
            occupancyDouble.isSelected = true
            occupancyDouble.tintColor = UIColor.systemBlue
            currentFilters.append("occupancy-double")
        }
    }
    
    @IBAction func tappedOccupancyTriple() {
        if occupancyTriple.isSelected == true {
            occupancyTriple.isSelected = false
            occupancyTriple.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "occupancy-triple"}
        }
        else {
            occupancyTriple.isSelected = true
            occupancyTriple.tintColor = UIColor.systemBlue
            currentFilters.append("occupancy-triple")
        }
    }
    
    @IBAction func tappedAcCentral() {
        if acCentral.isSelected == true {
            acCentral.isSelected = false
            acCentral.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "cooling_system-central"}
        }
        else {
            acCentral.isSelected = true
            acCentral.tintColor = UIColor.systemBlue
            currentFilters.append("cooling_system-central")
        }
    }
    
    @IBAction func tappedAcWindow() {
        if acWindow.isSelected == true {
            acWindow.isSelected = false
            acWindow.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "cooling_system-window unit"}
        }
        else {
            acWindow.isSelected = true
            acWindow.tintColor = UIColor.systemBlue
            currentFilters.append("cooling_system-window unit")
        }
    }
    
    @IBAction func tappedFlooringWood() {
        if flooringWood.isSelected == true {
            flooringWood.isSelected = false
            flooringWood.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "flooring-wood"}
        }
        else {
            flooringWood.isSelected = true
            flooringWood.tintColor = UIColor.systemBlue
            currentFilters.append("flooring-wood")
        }
    }
    
    @IBAction func tappedFlooringCarpet() {
        if flooringCarpet.isSelected == true {
            flooringCarpet.isSelected = false
            flooringCarpet.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "flooring-carpet"}
        }
        else {
            flooringCarpet.isSelected = true
            flooringCarpet.tintColor = UIColor.systemBlue
            currentFilters.append("flooring-carpet")
        }
    }
    
    @IBAction func tappedStorageCloset() {
        if storageCloset.isSelected == true {
            storageCloset.isSelected = false
            storageCloset.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "storage-closet"}
        }
        else {
            storageCloset.isSelected = true
            storageCloset.tintColor = UIColor.systemBlue
            currentFilters.append("storage-closet")
        }
    }
    
    @IBAction func tappedStorageWardrobe() {
        if storageWardrobe.isSelected == true {
            storageWardrobe.isSelected = false
            storageWardrobe.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "storage-wardrobe"}
        }
        else {
            storageWardrobe.isSelected = true
            storageWardrobe.tintColor = UIColor.systemBlue
            currentFilters.append("storage-wardrobe")
        }
    }
    
    @IBAction func tappedStorageDresser() {
        if storageDresser.isSelected == true {
            storageDresser.isSelected = false
            storageDresser.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "storage-dresser"}
        }
        else {
            storageDresser.isSelected = true
            storageDresser.tintColor = UIColor.systemBlue
            currentFilters.append("storage-dresser")
        }
    }
    
    @IBAction func tappedStorageCaptains() {
        if storageCaptains.isSelected == true {
            storageCaptains.isSelected = false
            storageCaptains.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "storage-captain's bed"}
        }
        else {
            storageCaptains.isSelected = true
            storageCaptains.tintColor = UIColor.systemBlue
            currentFilters.append("storage-captain's bed")
        }
    }
    
    @IBAction func tappedWindowNorth() {
        if windowN.isSelected == true {
            windowN.isSelected = false
            windowN.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "window_direction-north"}
        }
        else {
            windowN.isSelected = true
            windowN.tintColor = UIColor.systemBlue
            currentFilters.append("window_direction-north")
        }
    }
    
    @IBAction func tappedWindowNortheast() {
        if windowNE.isSelected == true {
            windowNE.isSelected = false
            windowNE.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "window_direction-northeast"}
        }
        else {
            windowNE.isSelected = true
            windowNE.tintColor = UIColor.systemBlue
            currentFilters.append("window_direction-northeast")
        }
    }
    
    @IBAction func tappedWindowEast() {
        if windowE.isSelected == true {
            windowE.isSelected = false
            windowE.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "window_direction-east"}
        }
        else {
            windowE.isSelected = true
            windowE.tintColor = UIColor.systemBlue
            currentFilters.append("window_direction-east")
        }
    }
    
    @IBAction func tappedWindowSoutheast() {
        if windowSE.isSelected == true {
            windowSE.isSelected = false
            windowSE.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "window_direction-southeast"}
        }
        else {
            windowSE.isSelected = true
            windowSE.tintColor = UIColor.systemBlue
            currentFilters.append("window_direction-southeast")
        }
    }
    
    @IBAction func tappedWindowSouth() {
        if windowS.isSelected == true {
            windowS.isSelected = false
            windowS.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "window_direction-south"}
        }
        else {
            windowS.isSelected = true
            windowS.tintColor = UIColor.systemBlue
            currentFilters.append("window_direction-south")
        }
    }
    
    @IBAction func tappedWindowSouthwest() {
        if windowSW.isSelected == true {
            windowSW.isSelected = false
            windowSW.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "window_direction-southwest"}
        }
        else {
            windowSW.isSelected = true
            windowSW.tintColor = UIColor.systemBlue
            currentFilters.append("window_direction-southwest")
        }
    }
    
    @IBAction func tappedWindowWest() {
        if windowW.isSelected == true {
            windowW.isSelected = false
            windowW.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "window_direction-west"}
        }
        else {
            windowW.isSelected = true
            windowW.tintColor = UIColor.systemBlue
            currentFilters.append("window_direction-west")
        }
    }
    
    @IBAction func tappedWindowNorthwest() {
        if windowNW.isSelected == true {
            windowNW.isSelected = false
            windowNW.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "window_direction-northwest"}
        }
        else {
            windowNW.isSelected = true
            windowNW.tintColor = UIColor.systemBlue
            currentFilters.append("window_direction-northwest")
        }
    }
    
    @IBAction func tappedFireplace() {
        if otherFireplace.isSelected == true {
            otherFireplace.isSelected = false
            otherFireplace.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "other-fireplace"}
        }
        else {
            otherFireplace.isSelected = true
            otherFireplace.tintColor = UIColor.systemBlue
            currentFilters.append("other-fireplace")
        }
    }
    
    @IBAction func tappedWindowSeat() {
        if otherWindowSeat.isSelected == true {
            otherWindowSeat.isSelected = false
            otherWindowSeat.tintColor = UIColor.systemGray2
            currentFilters.removeAll {$0 == "other-window seat"}
        }
        else {
            otherWindowSeat.isSelected = true
            otherWindowSeat.tintColor = UIColor.systemBlue
            currentFilters.append("other-window seat")
        }
    }
    
    
    @IBAction func tappedClear() {
        
        let allFilters = [
            "floor-1st": floor1st, "floor-2nd": floor2nd, "floor-3rd": floor3rd, "floor-4th": floor4th,
            "dorm-Merion": dormMerion, "dorm-New Dorm": dormNewDorm, "dorm-Radnor": dormRadnor,
            "occupancy-single": occupancySingle, "occupancy-double": occupancyDouble, "occupancy-triple": occupancyTriple,
            "cooling_system-central": acCentral, "cooling_system-window unit": acWindow,
            "flooring-wood": flooringWood, "flooring-carpet": flooringCarpet,
            "storage-closet": storageCloset, "storage-wardrobe": storageWardrobe, "storage-dresser": storageDresser, "storage-captain's bed": storageCaptains,
            "window_direction-north": windowN, "window_direction-northeast": windowNE, "window_direction-east": windowE, "window_direction-southeast": windowSE, "window_direction-south": windowS, "window_direction-southwest": windowSW, "window_direction-west": windowW, "window_direction-northwest": windowNW,
            "other-fireplace": otherFireplace, "other-window seat": otherWindowSeat]
        
        for (key, value) in allFilters {
            if currentFilters.contains(key) {
                if ((value) != nil) {
                    var temp = value
                    if (temp?.isSelected == true) {
                        temp!.isSelected = false
                        temp!.tintColor = UIColor.systemGray2
                    }
                }
            }
        }
        currentFilters.removeAll()
    }
    
    // DO NOT CONNECT THIS TO THE STORYBOARD!!
    @IBAction func tappedDone() {
        performSegue(withIdentifier: "unwindSegueToViewController", sender: self)
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSegueToViewController" {
            let vc = segue.destination as! ViewController
            print("-------------- APPLIED FILTERS ---------------")
            print(self.currentFilters)
            vc.currentFilters = self.currentFilters
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allFilters = [
            "floor-1st": floor1st, "floor-2nd": floor2nd, "floor-3rd": floor3rd, "floor-4th": floor4th,
            "dorm-Merion": dormMerion, "dorm-New Dorm": dormNewDorm, "dorm-Radnor": dormRadnor,
            "occupancy-single": occupancySingle, "occupancy-double": occupancyDouble, "occupancy-triple": occupancyTriple,
            "cooling_system-central": acCentral, "cooling_system-window unit": acWindow,
            "flooring-wood": flooringWood, "flooring-carpet": flooringCarpet,
            "storage-closet": storageCloset, "storage-wardrobe": storageWardrobe, "storage-dresser": storageDresser, "storage-captain's bed": storageCaptains,
            "window_direction-north": windowN, "window_direction-northeast": windowNE, "window_direction-east": windowE, "window_direction-southeast": windowSE, "window_direction-south": windowS, "window_direction-southwest": windowSW, "window_direction-west": windowW, "window_direction-northwest": windowNW,
            "other-fireplace": otherFireplace, "other-window seat": otherWindowSeat]
        
        for (key, value) in allFilters {
            if currentFilters.contains(key) {
                value?.isSelected = true
                value?.tintColor = UIColor.systemBlue
            }
        }
        floorTextLabel.isEditable = false
        floorTextLabel.isSelectable = false
        dormTextLabel.isEditable = false
        dormTextLabel.isSelectable = false
        occupancyTextLabel.isEditable = false
        occupancyTextLabel.isSelectable = false
        acTextLabel.isEditable = false
        acTextLabel.isSelectable = false
        

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
