//
//  ImageList.swift
//  CarTender
//
//  Created by R@NJ!T on 11/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//

import Foundation
import RealmSwift

class ImageList : Object{

    @objc dynamic var imageName = ""
    let carImage = LinkingObjects(fromType: SellingList.self, property: "imagelists")
}
