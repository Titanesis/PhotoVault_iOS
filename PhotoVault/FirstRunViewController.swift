//
//  FirstRunViewController.swift
//  PhotoVault
//
//  Created by Audrey Cigolotti on 05/01/2019.
//  Copyright © 2019 IF26. All rights reserved.
//

import UIKit

class FirstRunViewController: UIViewController {

    let keychain = KeychainSwift()
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var newPWlabel: UITextField!
    @IBOutlet weak var confirmPWlabel: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homepage = Storyboard.instantiateViewController(withIdentifier: "TableViewController") as! UITabBarController
        
        if newPWlabel.text != confirmPWlabel.text {
            descriptionLabel.text = "Les mots de passe ne correspondent pas, essayez encore !"
            } else {
                keychain.set(PVDatabase.instance.generateKey(withPassword: newPWlabel.text!) , forKey: "user_pw")
                PVDatabase.instance.setUserPassword(password: newPWlabel.text!)
            let appdelegate = UIApplication.shared.delegate
            appdelegate?.window??.rootViewController = homepage
            }
    }
}
