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
    @IBOutlet weak var pickerView: UIPickerView!
    
    let breeds: [String] = ["greyhound", "poodle"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Setup pickerView data source and delegate
        pickerView.dataSource = self
        pickerView.delegate = self
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

extension ViewController: UIPickerViewDataSource, UIPickerViewAccessibilityDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Request a random image from DogAPI
        DogAPI.requestRandomImage(breed: breeds[row], completionHandler: self.handleRandomImageResponse(imageData:error:))
    }
    
}

