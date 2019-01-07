//
//  Photo.swift
//  PhotoVault
//
//  Created by Audrey Cigolotti on 20/12/2018.
//  Copyright © 2018 IF26. All rights reserved.
//

import Foundation

class Photo {
    var id: Int64
    var album_id: Int64
    var data: String
    
    init() {
        id = 0
        album_id = 0
        data = "grumpy"
    }
    
    init(id: Int64, album_id: Int64, data: String){
        self.id = id
        self.album_id = album_id
        self.data = data
    }
    
    public var descriptor: String {
        return "Photo \(id), \(album_id) : \(data)"
    }
    
}
