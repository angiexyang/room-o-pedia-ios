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


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var roomsArray = [Room]()
    //want update room segue to change to view room segue
    var images: [String] = ["rad102.jpeg", "rad103.jpeg","mer100a.jpeg", "mer100.jpeg","rad101.jpeg"]
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "viewRoomSegue", sender: <#T##Any?#>)
//        
//    }
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
        return roomsArray.count
    }
    
    //customize what is displayed inside cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTableViewCell", for: indexPath) as! RoomTableViewCell
        
        //index path is which cell is clicked on
        let currRoom = roomsArray[indexPath.row]
        let dormAndNumber = currRoom.dorm + " " + currRoom.number
        cell.RoomTitleLabel?.text = dormAndNumber
        cell.RoomPreviewImageView?.image = UIImage(named: images[indexPath.row])
       // cell.RoomPreviewImageView?.image = currRoom.
        return cell
    }
    
    
    @IBOutlet weak var roomsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchRooms()
        print(roomsArray)
        
        //register custom cell to table view
        let nib = UINib(nibName: "RoomTableViewCell", bundle: nil)
        roomsTableView.register(nib, forCellReuseIdentifier: "RoomTableViewCell")
        roomsTableView.delegate = self
        roomsTableView.dataSource = self
        // Do any additional setup after loading the view.
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


