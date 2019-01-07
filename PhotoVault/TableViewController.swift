//
//  TableViewController.swift
//  PhotoVault
//
//  Created by Audrey Cigolotti on 19/12/2018.
//  Copyright © 2018 IF26. All rights reserved.
//

import UIKit
import SQLite
import os.log

var listeAlbums: [Album] = []
var gettedAlbums: [Album] = []
var getAlbumsNumberOfPhotos: [Int] = []

class TableViewController: UITableViewController {
    
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var albumName: UITextField!
    @IBOutlet var tableview: UITableView!
    
    let idModuleCellule = "AlbumCell"

    var album: Album?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        gettedAlbums = PVDatabase.instance.getAlbums()
        getAlbumsNumberOfPhotos = PVDatabase.instance.getNumberOfPhotosPerAlbum()

        self.tableView.reloadData()
    }
    
    @objc
    func loadList(){
        self.tableView.reloadData()
        gettedAlbums = PVDatabase.instance.getAlbums()
        getAlbumsNumberOfPhotos = PVDatabase.instance.getNumberOfPhotosPerAlbum()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        gettedAlbums = PVDatabase.instance.getAlbums()
        getAlbumsNumberOfPhotos = PVDatabase.instance.getNumberOfPhotosPerAlbum()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gettedAlbums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idModuleCellule, for: indexPath)
        
        cell.textLabel?.text = gettedAlbums[indexPath.row].name + " (\(getAlbumsNumberOfPhotos[indexPath.row]))"
        cell.imageView?.image = gettedAlbums[indexPath.row].photo
        cell.detailTextLabel?.text = gettedAlbums[indexPath.row].descript
        return cell
    }
    
    override func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let DvC = Storyboard.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
        
        DvC.getId = gettedAlbums[indexPath.row].id
        DvC.getName = gettedAlbums[indexPath.row].name as! String
        self.navigationController?.pushViewController(DvC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditPopUpViewController") as! EditPopUpViewController
            popOverVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            popOverVC.getId = gettedAlbums[indexPath.row].id
            self.present(popOverVC, animated: true)

        }
        editAction.backgroundColor = .gray
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            let aId = gettedAlbums[indexPath.row].id
            let isDeleted = PVDatabase.instance.deleteAlbum(cid: Int64(aId))
            gettedAlbums = PVDatabase.instance.getAlbums()
            if isDeleted{
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.tableView.endUpdates()
            }
            print("Deleting...")
        }
        deleteAction.backgroundColor = .red
        
        return [deleteAction, editAction]
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //self.hidesBottomBarWhenPushed = true
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
