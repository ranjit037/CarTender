//
//  SellingList.swift
//  CarTender
//
//  Created by R@NJ!T on 11/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//

import Foundation
import RealmSwift

class SellingList : Object{

    @objc dynamic var distance = ""
    @objc dynamic var id = -1
    var imagelists = List<ImageList>()
    @objc dynamic var make = ""
    @objc dynamic var miles = ""
    @objc dynamic var model = ""
    @objc dynamic var price = ""
    @objc dynamic var shareurl = ""
    @objc dynamic var status = ""
    let videolist = List<VideoList>()
    @objc dynamic var year = ""

    override class func primaryKey() -> String? {
        return "id"
    }

}
