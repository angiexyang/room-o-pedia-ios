//
//  LoginViewController.swift
//  room-o-pedia-ios
//
//  Created by Rachel H Lee on 3/21/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var welcomeMessage: UILabel!
    
    var inputEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmail.placeholder = "@bmc email only"
        welcomeMessage.text = "Welcome to Room-o-pedia!"
        
        verifyButton.layer.cornerRadius = 16
    }
    
    @IBAction func authorizeEmail(_sender: UIButton) {
        inputEmail = userEmail.text!
        print(inputEmail)
        if inputEmail.suffix(13) == "@brynmawr.edu" {
            self.shouldPerformSegue(withIdentifier: "TabBarController", sender: nil)
        }
        else {
            print("Wrong email")
            let alert = UIAlertController(title: "Sorry", message: "You need a Bryn Mawr email!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default) {_ in})
            self.present(alert, animated: true) {}
        }
    }
}


