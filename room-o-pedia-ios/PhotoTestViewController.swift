//
//  PhotoTestViewController.swift
//  room-o-pedia-ios
//
//  Created by Rachel H Lee on 2/22/22.
//

import Foundation
import UIKit
import Alamofire
import Network


struct Photo: Codable {
    var dorm: String
    var number: String
    var _id: String
    var photoURL: String
}


class PhotoTestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    
    // trial getting photo data
    func fetchPhotos() -> [Photo] {
        var photos:[Photo] = []
        AF.request("http://localhost:3000/photos").response { response in
            guard let photosData = response.data else {
                print("failed to assign response data")
              return
            }
            do {
                let decoder = JSONDecoder()
                photos = try decoder.decode([Photo].self, from: photosData)
                self.photosArray = photos
                print("PRINT FROM INSIDE DO")
                print(photos)
                print(self.photosArray)
            } catch {
                print("error here")
            }
        }
        print("PRINTING IN FUNC")
        print(self.photosArray)
        return photos
    }
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosArray = fetchPhotos()
        print("FROM VIEWDIDLOAD")
        print(photosArray)
        

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


       
