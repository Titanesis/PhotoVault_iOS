//
//  DbPersistance.swift
//  PhotoVault
//
//  Created by Audrey Cigolotti on 02/01/2019.
//  Copyright © 2019 IF26. All rights reserved.
//

import SQLite

class PVDatabase {
    /** Gestion de la persistance des données. **/
    
    private let albums = Table("albums")
    private let album_id = Expression<Int64>("id")
    private let album_name = Expression<String?>("name")
    private let album_description = Expression<String>("description")
    private let album_imgPreview = Expression<String>("imgPreview")
    private let album_password = Expression<String>("password")
    
    private let photos = Table("photos")
    private let photo_id = Expression<Int64>("id")
    private let photo_album_id = Expression<Int64>("album_id")
    private let photo_data = Expression<String>("data")
    
    private let users = Table("users")
    private let user_password = Expression<String>("password")
    
    static let instance = PVDatabase()
    private let database: Connection?
    let keychain = KeychainSwift()
    
    var pk = 1000;
    
    private init() {
        
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true).first!
        
        do {
            database = try Connection("\(path)/sqlite3")
            createTableAlbums()
            createTablePhotos()
            createTableUsers()
        } catch {
            database = nil
            print ("Unable to open database")
        }

    }
    
    func getPK() ->Int {
        // Génération d'un id aléatoire
        pk = Int.random(in: 0 ... 9999999)
        return pk
    }
    
    func createTableAlbums() {
        // Création de la table Albums
        print("Creating Albums")
        do {
            try database!.run(albums.create(ifNotExists: true) { table in
                table.column(album_id, primaryKey: true)
                table.column(album_name)
                table.column(album_description)
                table.column(album_imgPreview)
            })
        } catch {
            print("Unable to create table Albums")
        }
    }
    
    func createTablePhotos() {
        // Création de la table Photos
        print("Creating Photos")
        do {
            try database!.run(photos.create(ifNotExists: true) { table in
                table.column(photo_id, primaryKey: true)
                table.column(photo_album_id)
                table.column(photo_data)
            })
        } catch {
            print("Unable to create table Photos")
        }
    }
    
    func createTableUsers() {
        // Création de la table Users
        print("Creating Users")
        do {
            try database!.run(users.create(ifNotExists: true) { table in
                table.column(user_password)
            })
        } catch {
            print("Unable to create table Users")
        }
    }
    
    func setUserPassword(password: String){
        do {
            let passwordKey = generateKey(withPassword: password)
            let insert = users.insert(user_password <- passwordKey)
            keychain.set(password, forKey: passwordKey)
            try database!.run(insert)
            print("Password created")
        } catch {
            print("Set failed")
        }
    }
    
    func getUserPassword() -> String{
        var password : String = ""
        var passwordKey : String = ""
        do {
            
            for row in try database!.prepare(self.users){
                passwordKey = row[user_password]
            }
            password = keychain.get(passwordKey)!
        } catch {
            print("Cant't get key")
        }
        
        return password
    }
    
    func addAlbum(aName: String, aDescription: String, aImgPreview: String) -> Int64? {
        do {
            let insert = albums.insert(album_id <- Int64(self.getPK()), album_name <- aName, album_description <- aDescription, album_imgPreview <- aImgPreview)
            let id = try database!.run(insert)
            
            return id
        } catch {
            print("Insert failed")
            return nil
        }
    }
    
    func getAlbums() -> [Album] {
        var albums = [Album]()
        
        do {
            for album in try database!.prepare(self.albums) {
                albums.append(Album(
                    id: Int(album[album_id]),
                    name: album[album_name]!,
                    descript: album[album_description],
                    imageStr: album[album_imgPreview]))
            }
        } catch {
            print("Select failed")
        }
        
        return albums
    }
    
    func getNumberOfPhotosPerAlbum() -> [Int]{
        var numberOfPhotos = [Int]()
        
        do{
            for album in try database!.prepare(self.albums){
                let nbr = countPhotosFromAlbum(cid: album[album_id])
                numberOfPhotos.append(nbr)
            }
        } catch {
            print("Select failed")
        }
        
        return numberOfPhotos
    }
    
    func selectAlbum(cid: Int64) -> Album {
        var selectedAlbum = Album()
        let getalbums = albums.filter(album_id == cid)
        do {
            for album in try database!.prepare(getalbums) {
                selectedAlbum = Album(id: Int(cid), name: album[album_name] as! String, descript: album[album_description] as! String, imageStr: album[album_imgPreview] as! String)}
            return selectedAlbum
        } catch {
            print("Delete failed")
            return selectedAlbum
        }
    }
    
    func deleteAlbum(cid: Int64) -> Bool {
        do {
            let album = albums.filter(album_id == cid)
            try database!.run(album.delete())
            return true
        } catch {
            
            print("Delete failed")
        }
        return false
    }
    
    func updateAlbum(cid:Int64, newAlbum: Album) -> Bool {
        let album = albums.filter(album_id == cid)
        do {
            let update = album.update([
                album_name <- newAlbum.name,
                album_description <- newAlbum.descript,
                ])
            if try database!.run(update) > 0 {
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }
    
    func addPhoto(pAlbumId: Int64, pData: String) -> Int64? {
        do {
            let insert = photos.insert(photo_id <- Int64(self.getPK()), photo_album_id <- pAlbumId, photo_data <- pData)
            let id = try database!.run(insert)
            
            return id
        } catch {
            print("Insert failed")
            return nil
        }
    }
    
    func getPhotos() -> [Photo] {
        var photos = [Photo]()
        
        do {
            for photo in try database!.prepare(self.photos) {
                photos.append(Photo(
                    id: photo[photo_id],
                    album_id: photo[photo_album_id],
                    data: photo[photo_data]))
            }
        } catch {
            print("Select failed")
        }
        
        return photos
    }
    
    func getPhotosFromAlbum(cid: Int64) -> [Photo]{
        var photosAlbum = [Photo]()
        let selectedAlbum = photos.filter(photo_album_id == cid)
        
        do {
            for photo in try database!.prepare(selectedAlbum) {
                photosAlbum.append(Photo(
                    id: photo[photo_id],
                    album_id: photo[photo_album_id],
                    data: photo[photo_data]))
            }
        } catch {
            print("Select failed")
        }
        
        return photosAlbum
    }
    
    func countPhotosFromAlbum(cid : Int64) -> Int{
        let selectedAlbum = photos.filter(photo_album_id == cid)
        var count = 0
        do{
        count = try database!.scalar(selectedAlbum.select(photo_id.distinct.count))
        } catch {
            print("Can't count")
        }
    
        return count
    }
    
    func generateKey(withPassword password: String) -> String{
        let randomData = RNCryptor.randomData(ofLength: 32)
        let cipherData = RNCryptor.encrypt(data: randomData, withPassword: password)
        
        return cipherData.base64EncodedString()
    }
    
    func encryptData(data: String, encryptionKey: String) -> String{
        let messageData = data.data(using: .utf8)!
        let cipherData = RNCryptor.encrypt(data: messageData, withPassword: encryptionKey)
        return cipherData.base64EncodedString()
    }
    
    func decryptData(encryptedString: String, encryptionKey: String) -> String{
        do {
            let encryptedData = Data.init(base64Encoded: encryptedString)!
            let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: encryptionKey)
            let decryptedString = String(data: decryptedData, encoding: .utf8)!
            return decryptedString
        } catch {
            print(error)
            return "Erreur"
        }
    }
}

