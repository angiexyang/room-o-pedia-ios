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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddRoomViewController
        
        if segue.identifier == "updateRoomSegue" {
            vc.room = roomsArray[roomsTableView.indexPathForSelectedRow!.row]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath)
        let dormAndNumber = roomsArray[indexPath.row].dorm + " " + String(roomsArray[indexPath.row].number)
        cell.textLabel?.text = dormAndNumber
        return cell
    }
    
    @IBOutlet weak var roomsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchRooms()
        print(roomsArray)
        
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
