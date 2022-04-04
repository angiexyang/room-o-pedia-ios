//
//  APIFunctions.swift
//  room-o-pedia-ios
//
//  Created by Rachel H Lee on 2/4/22.
//

import Foundation
import Alamofire

/*struct Room: Codable {
    var dorm: String
    var number: String
    var _id: String
    var features: Features
}*/

struct Room: Codable {
    var dorm: String
    var number: String
    var _id: String
    var features: Features
    var photoURL: Array<String>
    
}

struct Features: Codable {
    var floor: String
    var occupancy: String
    var cooling_system: String
    var storage: Array<String>
    var flooring: String
    var window_direction: Array<String>
    var other: Array<String>
}

class APIFunctions {
    
    var delegate: DataDelegate?
   // var photo_delegate: DataDelegate?
    static let functions = APIFunctions()
    
    func fetchRooms() {
        AF.request("http://localhost:3000/rooms").response { response in
            //print(response.data!)
            
            let data = String(data: response.data!, encoding: .utf8)
            
            self.delegate?.updateArray(newArray: data!)
        }
    }
    
    
    func updateRoom(roomId: String, newURL: String, room: Room, features: Features, accessURL: String) {
        
        var photoURLArray = room.photoURL
        photoURLArray.append(newURL)
        
        let featureList: Parameters = [
            "floor": features.floor,
            "occupancy": features.occupancy,
            "cooling_system": features.cooling_system,
            "storage": features.storage,
            "flooring": features.flooring,
            "window_direction": features.window_direction,
            "other": features.other,
        ]
        let roomMain: Parameters = [
            "_id" : room._id,
            "dorm": room.dorm,
            "number": room.number,
            "photoURL": photoURLArray,
            "features": featureList
        ]
        let request = AF.request(accessURL, method: .put, parameters: roomMain, encoding: JSONEncoding.default, headers: nil)
        request.responseJSON(completionHandler: { response in
            guard response.error == nil else {
                print("error in updating")
                return
            }
            if let json = response.value as? [String:Any] {
                print("UPDATED SUCCESSFULLY")
                print(json)
            }
        })
    }
    
    
    func AddRoom(dorm: String, number: String){
        //does not work
        AF.request("http://localhost:3000/create_room_with_photo", method: .post, encoding: URLEncoding.httpBody, headers: ["dorm": dorm, "number": number]).responseDecodable(of: Room.self){
            response in
           // debugPrint(response)
        }
    }
}
