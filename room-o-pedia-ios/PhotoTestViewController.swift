//
//  PhotoTestViewController.swift
//  room-o-pedia-ios
//
//  Created by Rachel H Lee on 2/22/22.
//

import UIKit

class PhotoTestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var functions = APIFunctions()
    var photosArray = [Photo]()
    @IBOutlet weak var photosTableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellId")
        cell.textLabel?.text = self.photosArray[indexPath.row].photoURL
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return photosArray.count
    }
    
    
    

    override func viewDidLoad() {
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchPhotos()
        print(photosArray)
        super.viewDidLoad()
        

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

extension PhotoTestViewController: DataDelegate {
    func updateArray(newArray: String) {
        do {
            photosArray = try JSONDecoder().decode([Photo].self, from: newArray.data(using: .utf8)!)
            print(photosArray)
        } catch {
            print("Failed to decode")
        }
        self.photosTableView?.reloadData()
    }
    
}
