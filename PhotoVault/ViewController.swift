//
//  ViewController.swift
//  PhotoVault
//
//  Created by Audrey Cigolotti on 19/12/2018.
//  Copyright © 2018 IF26. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var PwLabel: UILabel!
    @IBOutlet weak var PwInput: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    
    let keychain = KeychainSwift()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.LoginButton.layer.cornerRadius = 8
        TitleLabel.text = "PhotoVault"
        DescriptionLabel.text = "L'application qui protège vos données intimes."
        PwLabel.text = "Entrez le mot de passe :"
        
    }


    @IBAction func LoginAction(_ sender: UIButton) {
        
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homepage = Storyboard.instantiateViewController(withIdentifier: "TableViewController") as! UITabBarController
        
        let passwrd = PVDatabase.instance.getUserPassword()
        
        if passwrd == PwInput.text {
            let appdelegate = UIApplication.shared.delegate
            appdelegate?.window??.rootViewController = homepage
        } else {
            print("Access denied")
            PwLabel.text = "Wrong password, try again:"
        }
    }
    
}

