//
//  TableViewController.swift
//  PhotoVault
//
//  Created by François-Luc Haghenbeek on 19/12/2018.
//  Copyright © 2018 IF26. All rights reserved.
//

import UIKit
import os.log

var listeAlbums: [Album] = []

class TableViewController: UITableViewController {
    
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var albumName: UITextField!
    @IBOutlet var tableview: UITableView!
    
    let idModuleCellule = "AlbumCell"
    let AlbumPreviewImage = [UIImage(named: "grumpy"), UIImage(named: "device-camera-icon"), UIImage(named: "yoda2")]
   //  let grumpy = UIImage(imageLiteralResourceName : "grumpy")
    // let AlbumPreviewImages: [UIImage] = [grumpy]
    

    var album: Album?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //let indexPath = IndexPath(item: row, sections: 0)
        //tableview.reloadRows(at: [indexPath], with: UITableView.RowAnimation)
        tableview?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listeAlbums.append(Album(name: "Ma chat", descript : "Prout"))
        listeAlbums.append(Album(name: "Mon appareil", descript : "Pipi"))
        listeAlbums.append(Album(name: "Mes yodas", descript : "Caca"))
        
        // Uncomment the following line to preserve selection /Users/francois-luchaghenbeek/Documents/PhotoVault/PhotoVault/Base.lproj/Main.storyboardbetween presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === cancelButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
    }*/
    

    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = albumName.text ?? ""
        album = Album(name: name)
    }
    */
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listeAlbums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idModuleCellule, for: indexPath)

        cell.textLabel?.text = listeAlbums[indexPath.row].name
        // cell.imageView?.image = AlbumPreviewImages[indexPath.row]
        cell.imageView?.image = AlbumPreviewImage[indexPath.row]
        cell.detailTextLabel?.text = listeAlbums[indexPath.row].descript

        return cell
    }
    
    override func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let DvC = Storyboard.instantiateViewController(withIdentifier: "CollectionCollectionViewController") as! CollectionCollectionViewController
        
        /*let DvC = Storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController*/
        
        DvC.getName = listeAlbums[indexPath.row].name as! String
        self.navigationController?.pushViewController(DvC, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
