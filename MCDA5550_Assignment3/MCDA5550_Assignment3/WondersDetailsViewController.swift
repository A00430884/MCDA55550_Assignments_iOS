//
//  WondersDetailsViewController.swift
//  MCDA5550_Assignment2
//
//  Created by MSc CDA on 2019-07-21.
//  Copyright © 2019 MSc CDA. All rights reserved.
//

import UIKit
import CoreLocation

class WondersDetailsViewController: UIViewController {
    
    @IBOutlet weak var wondersName: UILabel!
    @IBOutlet weak var wondersDescreption: UILabel!
    @IBOutlet weak var wondersUserRating: UILabel!
    @IBOutlet weak var wondersImageURL: UILabel!
    @IBOutlet weak var wondersCoordinates: UILabel!
    @IBOutlet weak var wondersImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var wondersDetail: [Wonders] = []
    
    //local Storage
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Wonders")
    
    var name = ""
    var description_str = ""
    var userRating = ""
    var imageURL = ""
    var coordinates = ""
    var urlImage:URL!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name = wondersDetail[0].name
//        description_str = wondersDetail[0].wonderDescription ?? "No Descreption"
        description_str = wondersDetail[0].wonderDescription ?? ""
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
        wondersCoordinates.text = "Coordinates: " + coordinates
        urlImage=URL(string: imageURL)
        downloaded(from: urlImage)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(WondersDetailsViewController.tappedMe))
        wondersImageView.addGestureRecognizer(tap)
        wondersImageView.isUserInteractionEnabled = true
    }
    
    @objc func tappedMe()
    {
        showAlert()
    }
    
    func showAlert() {
        
        let alertController = UIAlertController(title: "Copy Image", message: "Do you want to copy Image URL", preferredStyle: .alert)

        // Create Copy button
        let copyAction = UIAlertAction(title: "Copy", style: .default) { (action:UIAlertAction!) in
            UIPasteboard.general.string = self.imageURL
        }
        alertController.addAction(copyAction)
        // Create Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)

        // Present Dialog message
        present(alertController, animated: true, completion:nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "map_segue"{
            let mapViewController = segue.destination as? MapViewController
            
            let latitude = wondersDetail[0].coordinates[1]
            let longitude = wondersDetail[0].coordinates[0]
            
            mapViewController?.wonderLocation = CLLocation(latitude:latitude, longitude:longitude)
            mapViewController?.wonderLocation2 = CLLocation(latitude:latitude-0.01, longitude:longitude)
            mapViewController?.wonderName = name

        }
    }
    
    func downloaded(from url: URL) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        self.spinner(shouldSpin: true)
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.wondersImageView.image  = image
                self.spinner(shouldSpin: false)
            }
            }.resume()
    }
    
    func spinner (shouldSpin status: Bool) {
        if status == true {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    
}
