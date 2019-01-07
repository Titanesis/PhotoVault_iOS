//
//  DetailViewController.swift
//  PhotoVault
//
//  Created by Audrey Cigolotti on 20/12/2018.
//  Copyright © 2018 IF26. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var getName = String()

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var albumNavBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumNavBar.title! = getName

    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {

        navigationController?.popViewController(animated: true)
    }

}
