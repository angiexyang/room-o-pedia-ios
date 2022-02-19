//
//  APIFunctions.swift
//  room-o-pedia-ios
//
//  Created by Rachel H Lee on 2/4/22.
//

import Foundation
import Alamofire

struct Room: Decodable {
    var dorm: String
    var number: String
    var _id: String
    struct Features: Decodable {
        var floor: String
        var occupancy: String
        var cooling_system: String
        var storage: Array<String>
        var flooring: String
        var other: Array<String>
    }
    
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
    func AddRoom(dorm: String, number: String){
        //does not work
        AF.request("http://localhost:3000/create", method: .post, encoding: URLEncoding.httpBody, headers: ["dorm": dorm, "number": number]).responseDecodable(of: Room.self){
            response in
            debugPrint(response)
        }
    }
}
