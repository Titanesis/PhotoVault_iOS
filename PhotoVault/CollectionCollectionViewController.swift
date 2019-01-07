//
//  CollectionCollectionViewController.swift
//  PhotoVault
//
//  Created by François-Luc Haghenbeek on 02/01/2019.
//  Copyright © 2019 IF26. All rights reserved.
//

/*
import UIKit
import Photos

private let reuseIdentifier = "Cell"

class CollectionCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    var imageArray = [UIImage]()
    var getName = String()
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var albumNavBar: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addButton.layer.cornerRadius = 25
        albumNavBar.title! = getName
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        grabPhotos()
        // Do any additional setup after loading the view.
    }
    
    func grabPhotos(){
        
        print("Grab photo")
        let imgManager = PHImageManager.default()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        if let fetchResult : PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions){
            print("Fetch Result")
            if fetchResult.count > 0{
                print("Count > 0")
                for i in 0..<fetchResult.count{
                    print("\(i)")
                    imgManager.requestImage(for:fetchResult.object(at: i), targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOptions, resultHandler: {
                        image, error in
                        self.imageArray.append(image!)
                    })
                }
                print(imageArray.count)
            } else {
                print("No Photo")
                self.collectionView?.reloadData()
            }
        }
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
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

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = collectionView.frame.width / 3
        return CGSize(width: width, height: width)
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
*/

import UIKit

private let reuseIdentifier = "Cell"

class CollectionCollectionViewController: UICollectionViewController{
    var cellColor = true
    var getName = String()
    
    @IBOutlet weak var albumNavBar: UINavigationItem!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.addButton.layer.cornerRadius = 25
        albumNavBar.title! = getName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 100
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        cell.backgroundColor = cellColor ? UIColor.red : UIColor.blue
        cellColor = !cellColor
        
        return cell
    }
    
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

