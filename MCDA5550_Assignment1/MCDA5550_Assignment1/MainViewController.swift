//
//  MainViewController.swift
//  MCDA5550_Assignment1
//
//  Created by MSc CDA on 2019-07-17.
//  Copyright © 2019 MSc CDA. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
/*
     function executed on loading
 */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    /*
        function executed while closing the app
    */
    @IBAction func closeApp(_ sender: UIButton) {
        exit(-1)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
