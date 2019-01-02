//
//  Album.swift
//  PhotoVault
//
//  Created by François-Luc Haghenbeek on 20/12/2018.
//  Copyright © 2018 IF26. All rights reserved.
//

import Foundation

class Album {
    var name: String
    var descript: String
    // var photo: UIImage?
    
    init() {
        name = "?"
        descript = "?"
    }
    
    init(name: String, descript: String){
        self.name = name
        self.descript = descript
        //self.photo = photo
    }
    
    public var descriptor: String {
        return "Album \(name) : \(descript)"
    }
    
}
