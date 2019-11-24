//
//  DogAPI.swift
//  Randog
//
//  Created by Mustafa on 23/11/19.
//  Copyright © 2019 Mustafa Nafie. All rights reserved.
//

import Foundation
import UIKit

class DogAPI {
    enum Endpont {
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            }
        }
    }
    
    // A class function (Do not need an instance of the DogAPI class)
    class func requestRandomImage(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void) {
        let randomImageEndpoint = Endpont.randomImageForBreed(breed).url
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            // From JSON to Struct with Codable
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            completionHandler(imageData, nil)
        }
        task.resume()
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
        }
        task.resume()
    }
}
