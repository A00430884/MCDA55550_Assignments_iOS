//
//  GameViewController.swift
//  MCDA5550_Assignment1
//
//  Created by MSc CDA on 2019-07-17.
//  Copyright © 2019 MSc CDA. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    // Text field to display number
    @IBOutlet weak var textField: UITextField!
    // variable to hold integer
     var number:Int = 0
    /*
    function executed on loading
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        number = Int.random(in: 0 ... 10)
        textField.isEnabled = false
        textField.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }
    
    /*
    function executed on clicking stepper
    */
    @IBAction func stepper(_ sender: UIStepper) {
        textField.text = String (Int(sender.value))
    }
    
    /*
    function executed on clicking "Make a Guess?" button
    */
    @IBAction func onGuess(_ sender: UIButton) {
        print ("Entered Number: ", textField.text!)
        print ("Mystry Number: ", String(number))
        
        let enteredValue:Int? = Int(self.textField.text!)
        
        var hint = ""
        
        if (enteredValue! == number){
            print("You won")
            //Navigate to ResultViewController
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "ResultViewController")
            self.present(viewController, animated: true, completion: nil)
            
        }else{
            if (enteredValue! < number) {
                print("Hint: Increase the number")
                hint = "Higher"
            }else{
                print("Hint: Decrease the number")
                hint = "Lower"
            }
            let alert = UIAlertController(title: "Sorry, You Guessed Wrong. Please Try Again!", message: "Hint: Try a "+hint+" number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
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
