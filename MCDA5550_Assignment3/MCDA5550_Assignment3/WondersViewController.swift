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
    var dataToSave = Data()
    
    // Local Storage
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Wonders")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJsonFile()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SavedWondersSegue" {
            let savedWondersViewController = segue.destination as? SavedWondersViewController
            savedWondersViewController?.savedWonders = loadSavedData()
        }
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
        
        //check if wonders exist
        if wonders.count > 1{
            saveToLocalStorage()
        }
    }
    
    // MARK:- Local Storage using NSKeyedArchiver
    func saveToLocalStorage(){
        do{
            dataToSave = try NSKeyedArchiver.archivedData(withRootObject:wonders,requiringSecureCoding: false)
            try dataToSave.write(to:WondersViewController.ArchiveURL)
            
        }catch{
            print("Could not write")
        }
    }
    
    // MARK:- Retrieve Local Storage using NSKeyedUnarchiver
    func loadSavedData() ->[Wonders]{
        var savedWonders: [Wonders] = []
        do{
            if let loadedStrings = try
                NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dataToSave) as? [Wonders]{
                savedWonders = loadedStrings
            }
        }catch{
            print("Could not read")
        }
        return savedWonders
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
