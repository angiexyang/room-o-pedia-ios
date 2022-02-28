//
//  ViewRoomViewController.swift
//  room-o-pedia-ios
//
//  Created by Angie X Yang on 2/15/22.
//

import UIKit



class ViewRoomViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var room: Room!
    var currFeatures: Features!
    var featureArray = [String]()
    
    var photoURLArray = [String]()
    
    var tagCount = 0
   
    //number of rows
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tagTotal = 3 +  room.features.storage.count + room.features.other.count
        return tagTotal
    }
    
    //customize what is displayed inside cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "featureTag", for: indexPath) as! TagCollectionViewCell
        
        self.currFeatures = room.features
        
        featureArray = [self.currFeatures.floor, self.currFeatures.cooling_system, self.currFeatures.flooring]
        
        for s in self.currFeatures.storage{
            featureArray.append(s)
        }
        for o in self.currFeatures.other{
            featureArray.append(o)
        }
        if tagCount<featureArray.count{
            cell.roomTagLabel.text = featureArray[tagCount]
        }
        tagCount+=1
        return cell
    }
    


    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    @IBOutlet weak var roomImageView: UIImageView!
    
    @IBOutlet weak var dormRoomLabel: UILabel!
    
    
    
    
    //if user edits room, send room data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editRoomSegue" {
            let vc = segue.destination as! AddRoomViewController
            vc.room = room
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set label to selected room
        dormRoomLabel.text = room!.dorm + " " + room!.number
        self.photoURLArray = room.photoURL
        let currURL = photoURLArray[0]
        
        print(currURL)
        
        roomImageView.image = UIImage(named: "rad101")
       // tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
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

