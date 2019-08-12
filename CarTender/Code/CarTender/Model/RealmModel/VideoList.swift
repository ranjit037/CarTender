//
//  VideoList.swift
//  CarTender
//
//  Created by R@NJ!T on 11/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//

import Foundation
import RealmSwift

class VideoList : Object{
    @objc dynamic var parent_id = -1
    @objc dynamic var videoName = ""
}
