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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favTableView.delegate = self
        favTableView.dataSource = self
        
        favorited = defaults.stringArray(forKey: "roomFavorite")!
        favorited.sort()
        
        favTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorited.count
    }
    
    // var rowsWhichAreChecked = UserDefaults.standard.array(forKey: "roomFavorite") as? [String] ?? [String] ()
    
    /* if rowsWhichAreChecked.contains(dormAndNumber) {
            cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
 
        cell.favButtonPressed = { [ weak self ] in
            if self!.rowsWhichAreChecked.contains(dormAndNumber) {
                let removeFav = self?.rowsWhichAreChecked.lastIndex(where: {$0 == dormAndNumber})
                self!.rowsWhichAreChecked.remove(at: removeFav!)
         
                cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
            } else {
                cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                self!.rowsWhichAreChecked.append(dormAndNumber)
            }
            UserDefaults.standard.set(self!.rowsWhichAreChecked, forKey: "roomFavorite")
            print("ROOMS CHECKED: ")
            print(self!.rowsWhichAreChecked)
     */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favCell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavoriteTableViewCell
        let currRoom = favorited[indexPath.row]
        favCell.favLabel.text = currRoom
        return favCell
    }
    
    
    
}
