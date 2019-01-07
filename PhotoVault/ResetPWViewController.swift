//
//  ResetPWViewController.swift
//  PhotoVault
//
//  Created by Audrey Cigolotti on 05/01/2019.
//  Copyright © 2019 IF26. All rights reserved.
//

import UIKit

class ResetPWViewController: UIViewController {
    
    let keychain = KeychainSwift()

    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var currentPWEdit: UITextField!
    @IBOutlet weak var newPWEdit: UITextField!
    @IBOutlet weak var confirmPWEdit: UITextField!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        
    let passwrd = PVDatabase.instance.getUserPassword()
        
        if passwrd == currentPWEdit.text {
            if newPWEdit.text != confirmPWEdit.text {
                alertLabel.text = "New password and confirmation doesn't match."
            } else {
                PVDatabase.instance.setUserPassword(password: newPWEdit.text!)
                dismiss(animated: true, completion: nil)
            }
        } else {
            alertLabel.text = "Wrong current password."
        }
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}
