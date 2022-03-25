//
//  FavoriteViewController.swift
//  room-o-pedia-ios
//
//  Created by Rachel H Lee on 3/24/22.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var favTableView: UITableView!
    
    let defaults = UserDefaults.standard
    var favorited = [String]()
    var starredRooms = [Room]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favRoomSegue" {
            let vc = segue.destination as! ViewRoomViewController
            vc.room = starredRooms[favTableView.indexPathForSelectedRow!.row]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favTableView.delegate = self
        favTableView.dataSource = self
        
        favorited = defaults.stringArray(forKey: "roomFavorite")!
        favorited.sort()
        
        if let data = defaults.data(forKey: "starredRooms") {
            starredRooms = try! PropertyListDecoder().decode([Room].self, from: data)
        }
        starredRooms.sort{$0.dorm + " " + $0.number < $1.dorm + " " + $1.number}
        
        
        favTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorited.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favCell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavoriteTableViewCell
        let currLabel = favorited[indexPath.row]
        favCell.favLabel.text = currLabel
        favCell.nextSign.image = (UIImage(named: "caret"))
        return favCell
    }
    
    
    
}
