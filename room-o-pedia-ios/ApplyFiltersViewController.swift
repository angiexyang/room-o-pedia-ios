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
    @IBOutlet weak var floor1st: UIButton!
    @IBOutlet weak var floor2nd: UIButton!
    @IBOutlet weak var floor3rd: UIButton!
    
    @IBOutlet weak var testDone: UIButton!
    
    
    @IBAction func tappedFloor1st() {
        if floor1st.isSelected == true {
            floor1st.isSelected = false
            floor1st.tintColor = UIColor.systemRed
            currentFilters.removeAll {$0 == "floor-1st"}
        }
        else {
            floor1st.isSelected = true
            floor1st.tintColor = UIColor.systemGreen
            currentFilters.append("floor-1st")
        }
    }
    
    @IBAction func tappedFloor2nd() {
        if floor2nd.isSelected == true {
            floor2nd.isSelected = false
            floor2nd.tintColor = UIColor.systemRed
            currentFilters.removeAll {$0 == "floor-2nd"}
        }
        else {
            floor2nd.isSelected = true
            floor2nd.tintColor = UIColor.systemGreen
            currentFilters.append("floor-2nd")
        }
    }
    
    @IBAction func tappedFloor3rd() {
        if floor3rd.isSelected == true {
            floor3rd.isSelected = false
            floor3rd.tintColor = UIColor.systemRed
            currentFilters.removeAll {$0 == "floor-3rd"}
        }
        else {
            floor3rd.isSelected = true
            floor3rd.tintColor = UIColor.systemGreen
            currentFilters.append("floor-3rd")
        }
    }
    
    @IBAction func tappedDone() {
        performSegue(withIdentifier: "unwindSegueToViewController", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSegueToViewController" {
            let vc = segue.destination as! ViewController
            print("APPLY FILTERS VIEW CONTROLLER CHECK HERE")
            print(self.currentFilters)
            vc.currentFilters = self.currentFilters
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentFilters.contains("floor-1st") {
            floor1st.isSelected = true
            floor1st.tintColor = UIColor.systemGreen
        }
        if currentFilters.contains("floor-2nd") {
            floor2nd.isSelected = true
            floor2nd.tintColor = UIColor.systemGreen
        }
        if currentFilters.contains("floor-3rd") {
            floor3rd.isSelected = true
            floor3rd.tintColor = UIColor.systemGreen
        }
        floorTextLabel.isEditable = false
        floorTextLabel.isSelectable = false

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
