//
//  ViewController.swift
//  Randog
//
//  Created by Mustafa on 23/11/19.
//  Copyright © 2019 Mustafa Nafie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Request a random image from DogAPI
        DogAPI.requestRandomImage(completionHandler: self.handleRandomImageResponse(imageData:error:))
    }
    
    func handleRandomImageResponse(imageData: DogImage?, error: Error?) {
        guard let imageURL = URL(string: imageData!.message) else {
            return
        }
        DogAPI.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:error:))
    }
    
    // A helper method to update the UI
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
}

