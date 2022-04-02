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
    var photoCount = 0
   
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    //number of rows
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.tagCollectionView {
            var tagTotal = 3 +  room.features.storage.count + room.features.window_direction.count
            if (!room.features.other.isEmpty && room.features.other[0] != ""){
                tagTotal = tagTotal + room.features.other.count
            }
            return tagTotal
        } else {
            print("number of photos \(photoURLArray.count)")
            return photoURLArray.count
        }
    }
    
    //customize what is displayed inside cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.tagCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "featureTag", for: indexPath) as! TagCollectionViewCell
            cell.roomTagLabel.font = UIFont.systemFont(ofSize: 11)
            self.currFeatures = room.features
        
            //make feature array with format feature-value to match filters in view controller
            let floorFeature = "floor-"+self.currFeatures.floor
            let coolingFeature = "cooling_system-"+self.currFeatures.cooling_system
            let flooringFeature = "flooring-"+self.currFeatures.flooring
        
            featureArray = [floorFeature, coolingFeature, flooringFeature]

            for s in self.currFeatures.storage{
                featureArray.append("storage-"+s)
            }
        
            for w in self.currFeatures.window_direction{
                featureArray.append("window_direction-"+w)
            }
        
            for o in self.currFeatures.other{
                if (o != ""){
                    featureArray.append("other-"+o)
                }
            }
        
            //put in tag labels for each cell, reformat string
            if tagCount<featureArray.count{
                let currTag = featureArray[tagCount]
                let dashIndex = currTag.firstIndex(of: "-")
                let stringCut = currTag.index(after: dashIndex!)
            
                //if feature is window direction, add "windows" after direction on the tag
                let currFeature = String(currTag[...currTag.index(before: dashIndex!)])
                if (currFeature == "window_direction"){
                    cell.roomTagLabel.text =    String(currTag[stringCut...])+" windows"
                } else {
                    cell.roomTagLabel.text = String(currTag[stringCut...])
                }
            }
            tagCount+=1
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
            if photoCount < photoURLArray.count {
                let currPhoto = photoURLArray[photoCount]
                cell.roomPhoto.loadFrom(URLAddress: currPhoto)
                cell.clipsToBounds = true
                //cell.roomPhoto.image = UIImage(named: "owl")
                cell.roomPhoto.contentMode = .scaleAspectFit
                //cell.frame = CGRect(x: 0, y: 0, width: self.photoCollectionView.frame.width/2, height: self.photoCollectionView.frame.height/2)
            }
            photoCount+=1
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.photoCollectionView {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else {
            return CGSize(width: 120, height: 44)
        }
    }

    @IBOutlet weak var tagCollectionView: UICollectionView!
    //@IBOutlet weak var roomImageView: UIImageView!
    

    @IBOutlet weak var dormRoomLabel: UILabel!
    
    //when tag is clicked, perform unwind segue back to view controller
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.tagCollectionView {
            print("indexpath\t", indexPath)
            print("row\t", indexPath.row)
            //pass through feature selected as an array of 1 string
            performSegue(withIdentifier: "tagClickSegue", sender: [featureArray[indexPath.row]])
        }
}
    
    //prepare for unwind segue back to view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        vc.currentFilters = (sender as? [String])!
    }
  
    //------page controller func--------
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    override func viewDidLayoutSubviews() {
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }
    //---------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set label to selected room
        dormRoomLabel.text = room!.dorm + " " + room!.number
        
        // GET PHOTOURLS
        self.photoURLArray = room.photoURL
        self.pageControl.numberOfPages = photoURLArray.count
        //let currURL = photoURLArray[0] // GET FIRST FOR TESTER
        
        //roomImageView.loadFrom(URLAddress: currURL)
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        
        photoCollectionView.isPagingEnabled = true
        photoCollectionView.showsHorizontalScrollIndicator = false
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

// LOAD PHOTO FROM URL
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}

