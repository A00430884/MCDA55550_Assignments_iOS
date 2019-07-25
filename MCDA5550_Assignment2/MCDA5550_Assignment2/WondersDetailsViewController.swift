//
//  WondersDetailsViewController.swift
//  MCDA5550_Assignment2
//
//  Created by MSc CDA on 2019-07-21.
//  Copyright © 2019 MSc CDA. All rights reserved.
//

import UIKit

class WondersDetailsViewController: UIViewController {
    
    @IBOutlet weak var wondersName: UILabel!
    @IBOutlet weak var wondersDescreption: UILabel!
    @IBOutlet weak var wondersUserRating: UILabel!
    @IBOutlet weak var wondersImageURL: UILabel!
    @IBOutlet weak var wondersCoordinates: UILabel!
    
    @IBOutlet weak var wondersImageView: UIImageView!
    
    var wondersDetail: [Wonders] = []
    
    var name = ""
    var description_str = ""
    var userRating = ""
    var imageURL = ""
    var coordinates = ""
    var urlImage:URL!;
    
    
//    var name = ""
//    let name: String = ""
//    let description: String?
//    let userRating: Double = 0.0
//    let imageURL: String = ""
//    let coordinates: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (wondersDetail)
//        wondersName.text = "This is the name "+name
        
        name = wondersDetail[0].name
        description_str = wondersDetail[0].description ?? ""
        if(description_str == "")
        {
            wondersDescreption.isHidden = true
        }
        userRating = String(wondersDetail[0].userRating)
        imageURL = wondersDetail[0].imageURL
        coordinates = String(wondersDetail[0].coordinates[0]) + " : " + String(wondersDetail[0].coordinates[1])
        
        wondersName.text = "Name: " + name
        wondersDescreption.text = "Description: " + description_str
        wondersUserRating.text = "UserRating: " + userRating
        //wondersImageURL.text = "ImageURL: " + imageURL
        wondersCoordinates.text = "Coordinates: " + coordinates
        urlImage=URL(string: imageURL)
       downloaded(from: urlImage)
        
        
        
    }
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
//      contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.wondersImageView.image  = image
            }
            }.resume()
    }
    
    

}
