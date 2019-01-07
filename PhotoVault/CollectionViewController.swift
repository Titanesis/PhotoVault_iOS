//
//  CollectionViewController.swift
//  PhotoVault
//
//  Created by Audrey Cigolotti on 03/01/2019.
//  Copyright © 2019 IF26. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imageArray = [UIImage]()
    var getName = String()
    var getId = Int()
    var imagePicker = UIImagePickerController()
    let keychain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let albumName = getName
        let albumId = getId
        self.title? = albumName
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add photo",style: .plain, target:self, action: #selector(addTapped))
         self.clearsSelectionOnViewWillAppear = false
        grabPhotosFromAlbum(aId: albumId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.collectionView.reloadData()
    }
    
    @objc
    func addTapped(sender: AnyObject){
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!

        self.present(imagePicker, animated: true){
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let albumId = getId
        print(imageArray.count)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        self.imageArray.append(selectedImage)
        print(imageArray.count)
        
        //let key_psswrd = PVDatabase.instance.getUserPassword()
        let key_psswrd = keychain.get("user_pw")!
        
        let imageData:NSData = selectedImage.pngData()! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        let cryptedStrBase64 = PVDatabase.instance.encryptData(data: strBase64, encryptionKey: key_psswrd)
        
        PVDatabase.instance.addPhoto(pAlbumId: Int64(albumId), pData: cryptedStrBase64)
        imagePicker.dismiss(animated: true,completion: nil)
    }
    
    @objc func grabPhotosFromAlbum(aId: Int){
        print("Grabbing photos")
        //let key_psswrd = PVDatabase.instance.getUserPassword()
        let key_psswrd = keychain.get("user_pw")!
        
        let images = PVDatabase.instance.getPhotosFromAlbum(cid: Int64(aId))
        for image in images{
            let decryptImage = PVDatabase.instance.decryptData(encryptedString: image.data, encryptionKey: key_psswrd)
            let imageData = Data(base64Encoded: decryptImage, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
            let myImage = UIImage(data: imageData)!
            imageArray.append(myImage)
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        imageView.image = imageArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width/3 - 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 3.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
        
        controller.getImage = imageArray[indexPath.row] as! UIImage
        self.navigationController?.pushViewController(controller, animated: true)
    }

}


