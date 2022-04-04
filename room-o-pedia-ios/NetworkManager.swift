//
//  NetworkManager.swift
//  room-o-pedia-ios
//
//  Created by Rachel H Lee on 4/3/22.
//

import UIKit
import Alamofire
import PromiseKit
import AWSS3

class NetworkManager {
    
    static let api = NetworkManager()
    
    private init(){}
    
    func uploadImage(image: UIImage) -> Promise<URL> {
        return Promise { resolver in
            let progressBlock: AWSS3TransferUtilityProgressBlock = {
                task, progress in
                print("image uploaded percentage : ", progress.fractionCompleted)
            }
            let transferUtility = AWSS3TransferUtility.default()
            let imageData = image.jpegData(compressionQuality: 0.4)
            let bucketName = "room-o-pedia-test"
            let name = ProcessInfo.processInfo.globallyUniqueString+".jpg"
            let expression = AWSS3TransferUtilityUploadExpression()
            expression.progressBlock = progressBlock
            expression.setValue("public-read", forRequestHeader: "x-amz-acl")
            
            transferUtility.uploadData(imageData!, bucket: bucketName,key: name, contentType: "image/jpeg", expression: expression, completionHandler: {
                task, error in
                if let error = error {
                    resolver.reject(error)
                } else {
                    let imageUrl = URL(string:"https://room-o-pedia-test.s3.amazonaws.com/\(name)")
                    resolver.fulfill(imageUrl!)
                }
                
            })
        }
    }
}
