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
        let cellIdentifier = "RoomCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RoomTableViewCell
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
