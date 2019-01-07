//
//  EditPopUpViewController.swift
//  PhotoVault
//
//  Created by Audrey Cigolotti on 03/01/2019.
//  Copyright © 2019 IF26. All rights reserved.
//

import UIKit

class EditPopUpViewController: UIViewController {

    var getId = Int()
    @IBOutlet weak var popUpTitle: UILabel!
    
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumDescriptLabel: UILabel!
    
    @IBOutlet weak var albumNameEdit: UITextField!
    @IBOutlet weak var albumDescriptEdit: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let idAlbum = getId
        let editableAlbum = PVDatabase.instance.selectAlbum(cid: Int64(idAlbum))
        print(editableAlbum.name)
    }
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        let newAlbumName = albumNameEdit.text
        let newAlbumDescript = albumDescriptEdit.text
        
        let idAlbum = getId
        let editableAlbum = PVDatabase.instance.selectAlbum(cid: Int64(idAlbum))
        
        if(newAlbumName) != ""{
            let newnewName = newAlbumName
            editableAlbum.name = newnewName as! String
        }
        
        if(newAlbumDescript) != ""{
            let newnewDescript = newAlbumDescript
            editableAlbum.descript = newnewDescript as! String
        }
        
        let hasBeenUpdated = PVDatabase.instance.updateAlbum(cid: Int64(idAlbum), newAlbum: editableAlbum)
        if(hasBeenUpdated){
            print("Update Réussi")
        } else{
            print("Pas marché")
        }
        dismiss(animated: true)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
