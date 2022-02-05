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
    var number: Int
    var _id: String
}

class APIFunctions {
    
    var delegate: DataDelegate?
    static let functions = APIFunctions()
    
    func fetchRooms() {
        AF.request("http://localhost:3000/rooms").response { response in
            print(response.data)
            
            let data = String(data: response.data!, encoding: .utf8)
            
            self.delegate?.updateArray(newArray: data!)
        }
    }
}
