//
//  PhotoViewController.swift
//  PhotoVault
//
//  Created by Audrey Cigolotti on 03/01/2019.
//  Copyright © 2019 IF26. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var getImage = UIImage()

    @IBOutlet weak var affichImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageAffichee = getImage
        affichImg.image = imageAffichee
    }
}
