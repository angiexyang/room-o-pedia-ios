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
        var tagTotal = 3 +  room.features.storage.count + room.features.window_direction.count
        if (!room.features.other.isEmpty && room.features.other[0] != ""){
            tagTotal = tagTotal + room.features.other.count
        }
        return tagTotal
    }
    
    //customize what is displayed inside cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "featureTag", for: indexPath) as! TagCollectionViewCell
        cell.roomTagLabel.font = UIFont.systemFont(ofSize: 11)
        self.currFeatures = room.features
        
        featureArray = [self.currFeatures.floor, self.currFeatures.cooling_system, self.currFeatures.flooring]
        
        for s in self.currFeatures.storage{
            featureArray.append(s)
        }
        
        for w in self.currFeatures.window_direction{
            featureArray.append(w + " windows")
        }
        
        for o in self.currFeatures.other{
            if (o != "") {
                featureArray.append(o)
            }
            
        }
        if tagCount<featureArray.count{
            cell.roomTagLabel.text = featureArray[tagCount]
        }
        tagCount+=1
        return cell
    }
    


    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    @IBOutlet weak var roomImageView: UIImageView!
    
    /* TESTING SCROLL VIEW */
    /*
     
    var imageScrollView: UIScrollView!
    var roomImages = [UIImageView]()
    
     scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
         scrollView.backgroundColor = .systemTeal
         // Set the contentSize to 100 times the height of the phone's screen so that
         scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: UIScreen.main.bounds.height*100)
         view.addSubview(scrollView)
     
     for i in 0...100 {
           images.append(UIImageView(image: UIImage(systemName: "person.3.fill")))
           images[i].frame = CGRect(x: 0, y: UIScreen.main.bounds.height*CGFloat(i), width: view.frame.width, height: view.frame.height)
           images[i].contentMode = .scaleAspectFit
           scrollView.addSubview(images[i])
         }
     
    */
    
    @IBOutlet weak var dormRoomLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set label to selected room
        dormRoomLabel.text = room!.dorm + " " + room!.number
        
        // GET PHOTOURLS
        self.photoURLArray = room.photoURL
        let currURL = photoURLArray[0] // GET FIRST FOR TESTER
        
        roomImageView.loadFrom(URLAddress: currURL)
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

