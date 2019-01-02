//
//  DetailViewController.swift
//  PhotoVault
//
//  Created by François-Luc Haghenbeek on 20/12/2018.
//  Copyright © 2018 IF26. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var getName = String()
    //var getImage = UIImage()
    
   // @IBOutlet weak var imgImage: UIImageView!

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var albumNavBar: UINavigationItem!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //imgImage.image = getImage
        
        albumNavBar.title! = getName
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
       // dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
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
