//
//  MainViewController.swift
//  MCDA5550_Assignment2
//
//  Created by MSc CDA on 2019-07-21.
//  Copyright © 2019 MSc CDA. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var teamInfoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeApp(_ sender: UIButton) {
        exit(-1)
    }

}
