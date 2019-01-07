//
//  Album.swift
//  PhotoVault
//
//  Created by Audrey Cigolotti on 20/12/2018.
//  Copyright © 2018 IF26. All rights reserved.
//

import Foundation
import UIKit

class Album {
    var id: Int
    var name: String
    var descript: String
    var photo: UIImage
    
    init() {
        id = 0
        name = "?"
        descript = "?"
        photo = UIImage(named : "device-camera-icon")!
    }
    
    init(name: String, descript: String){
        self.id = 0
        self.name = name
        self.descript = descript
        self.photo = UIImage(named: "device-camera-icon")!
    }
    
    init(id: Int, name: String, descript: String, imageStr: String){
        self.id = id
        self.name = name
        self.descript = descript
        self.photo = UIImage(named: imageStr)!
    }
    
    public var descriptor: String {
        return "Album \(name) : \(descript)"
    }
    
}
