//
//  ViewController.swift
//  PhotoVault
//
//  Created by François-Luc Haghenbeek on 19/12/2018.
//  Copyright © 2018 IF26. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var PwLabel: UILabel!
    @IBOutlet weak var PwInput: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.LoginButton.layer.cornerRadius = 10
        TitleLabel.text = "PhotoVault"
        DescriptionLabel.text = "Protege tes photos wesh, pour l'instant il y a pas de mdp."
        PwLabel.text = "Password :"
        //LoginButton.titleLabel = "Login"
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func LoginAction(_ sender: UIButton) {
    }
    
}

