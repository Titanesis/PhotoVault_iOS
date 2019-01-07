//
//  AlbumViewController.swift
//  PhotoVault
//
//  Created by Audrey Cigolotti on 20/12/2018.
//  Copyright © 2018 IF26. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var AlbumNameLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var AlbumNameField: UITextField!
    @IBOutlet weak var DescriptionField: UITextField!
    @IBOutlet var tableview: UITableView!
    
    var newAlbumName : String = ""
    var newAlbumDescription : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        
        self.newAlbumName = AlbumNameField.text!
        self.newAlbumDescription = DescriptionField.text!
        
        let id = PVDatabase.instance.addAlbum(aName: self.newAlbumName, aDescription: self.newAlbumDescription, aImgPreview: "no-photo")
        
        tableview?.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
