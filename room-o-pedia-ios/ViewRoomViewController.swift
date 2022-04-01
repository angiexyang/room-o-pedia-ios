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
        
        //make feature array with format feature-value to match filters
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
        
        //put in tag labels for each cell
        if tagCount<featureArray.count{
            let currTag = featureArray[tagCount]
            let dashIndex = currTag.firstIndex(of: "-")
            let stringCut = currTag.index(after: dashIndex!)
            
            //if feature is window direction, add "windows" after direction on the tag
            let currFeature = String(currTag[...currTag.index(before: dashIndex!)])
            if (currFeature == "window_direction"){
                cell.roomTagLabel.text = String(currTag[stringCut...])+" windows"
            }
            else{
                cell.roomTagLabel.text = String(currTag[stringCut...])}
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
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //tagCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
        //let item = indexPath.row
        print("indexpath\t", indexPath)
        print("row\t", indexPath.row)
        print("selectedFeature\t", [featureArray[indexPath.row]])
       // self.performSegue(withIdentifier: "tagClickSegue", sender: indexPath.row)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("here1")
        if segue.identifier == "tagClickSegue"  {
           // let selectedIndexPath = sender as? NSIndexPath
            print("here2")
           // let vc = segue.destination as! ViewController
            print("here3")
            print("featurearray\t", featureArray)
         
            //print("indexPath\t", featureArray[tagCollectionView.indexPathsForSelectedItems])
          //  print("indexPath1\t", featureArray[tagCollectionView.indexPathsForSelectedItems?.first.row])
           // print("indexPath2\t", tagCollectionView.indexPathsForSelectedItems as Any)
          //  print("indexPathRow\t", selectedIndexPath!.row)
           // print("selectedtag\t",[featureArray[selectedIndexPath!.row] as String])
            //vc.currentFilters = [featureArray[selectedIndexPath!.row] as String]
//            vc.currentFilters = [ featureArray[tagCollectionView.indexPathsForSelectedItems?.first!.row] as String]
           // print("sender\t", sender)
            //print("selectedFeature\t", sender)
//            vc.currentFilters = [featureArray[sender.row]]
//            if let cell = sender as? TagCollectionViewCell, let indexPath = self.collectionView(<#T##collectionView: UICollectionView##UICollectionView#>, cellForItemAt: <#T##IndexPath#>)
//                vc.currentFilters = [featureArray[sender as Int]]
            
            if let cell = sender as? TagCollectionViewCell, let indexPath = self.tagCollectionView.indexPath(for: cell){
                let vc = segue.destination as! ViewController
                vc.currentFilters = [featureArray[indexPath.row]]

            }
            print("here4")
        }


    }
    
   
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

