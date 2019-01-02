//
//  AlbumViewController.swift
//  PhotoVault
//
//  Created by François-Luc Haghenbeek on 20/12/2018.
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

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        
        self.newAlbumName = AlbumNameField.text!
        self.newAlbumDescription = DescriptionField.text!
        
        listeAlbums.append(Album(name: self.newAlbumName, descript: self.newAlbumDescription))
        
        print (listeAlbums[3].descriptor)
        
        tableview?.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
