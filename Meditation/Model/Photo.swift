//
//  Photo.swift
//  Meditation
//
//  Created by user on 23.11.2022.
//

import Foundation
import RealmSwift

class Photo: Object {
    
    @objc dynamic var photoData: Data?
    @objc dynamic var time: String?
    
    
}
