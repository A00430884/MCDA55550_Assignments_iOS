//
//  WondersViewController.swift
//  MCDA5550_Assignment2
//
//  Created by MSc CDA on 2019-07-21.
//  Copyright © 2019 MSc CDA. All rights reserved.
//

import UIKit

class WondersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var wonders: [Wonders] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJsonFile()
        // Do any additional setup after loading the view.
    }
    
    func loadJsonFile() {
        guard let jsonFile = Bundle.main.path(forResource: "wonders", ofType: "json") else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: jsonFile))
        guard
            let data = optionalData,
            let json = try? JSONSerialization.jsonObject(with: data),
            let dictioary = json as? [String:Any],
            let wondersDictionary  = dictioary["features"] as? [[String: Any]]
            else { return }
        let validWonders = wondersDictionary.compactMap{ Wonders(wonder: $0) }
        wonders.append(contentsOf: validWonders)
    }
}

extension WondersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wonders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WondersTableViewCell", for: indexPath) as? WondersTableViewCell else { return UITableViewCell() }
        
        let index = indexPath.row
        cell.wonderLabel.text = String(index+1)+". "+wonders[index].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WondersDetailsViewController") as? WondersDetailsViewController
        
//        vc?.name = wonders[indexPath.row].name
        vc?.wondersDetail = [wonders[indexPath.row]]
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
    
    
}
