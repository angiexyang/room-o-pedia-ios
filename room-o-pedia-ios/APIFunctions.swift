//
//  APIFunctions.swift
//  room-o-pedia-ios
//
//  Created by Rachel H Lee on 2/4/22.
//

import Foundation
import Alamofire

struct Room: Codable {
    var dorm: String
    var number: String
    var _id: String
    var features: Features
}

struct Features: Codable {
    var floor: String
    var occupancy: String
    var cooling_system: String
    var storage: Array<String>
    var flooring: String
    var other: Array<String>
}


struct Photo: Codable {
    var dorm: String
    var number: String
    var _id: String
    var photoURL: String
}





class APIFunctions {
    
    var delegate: DataDelegate?
    static let functions = APIFunctions()
    
    func fetchRooms() {
        AF.request("http://localhost:3000/rooms").response { response in
            print(response.data!)
            
            let data = String(data: response.data!, encoding: .utf8)
            
            self.delegate?.updateArray(newArray: data!)
        }
    }
    
    // trial getting photo data
    func fetchPhotos() {
        AF.request("http://localhost:3000/photos").responseJSON { response in
            print("PHOTOS")
            print(response.result)
        }
    }
    
    
    
    func AddRoom(dorm: String, number: String){
        //does not work
        AF.request("http://localhost:3000/create", method: .post, encoding: URLEncoding.httpBody, headers: ["dorm": dorm, "number": number]).responseDecodable(of: Room.self){
            response in
            debugPrint(response)
        }
    }
}
