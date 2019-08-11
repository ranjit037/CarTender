//
//  Constants.swift
//  CarTender
//
//  Created by R@NJ!T on 10/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//

import UIKit

let APP_NAME = "Car Tender"
let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate

//MARK: - StoryBoard name constant
let STORYBOARD_MAIN = "Main"

//MARK: - ViewController identifier constant
let idMainVC = "idMainVC"

//MARK: - Cell xid identifier constant
let xibCarListCell = "CarListCell"
let xibCarListHeaderCell = "CarListHeaderCell"
let xibImageListCell = "ImageListCell"

//MARK: - Cell identifier constant
let idCarListCell = "idCarListCell"
let idCarListHeaderCell = "idCarListHeaderCell"
let idImageListCell = "idImageListCell"

enum Cell_Header_Labels:Int {
    case leading = 0
    case center
    case trailing
}

enum Cell_Footer_Labels:Int {
    case leading = 0
    case trailing
}