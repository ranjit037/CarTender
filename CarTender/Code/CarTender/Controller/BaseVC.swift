//
//  BaseVC.swift
//  CarTender
//
//  Created by R@NJ!T on 11/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.2235294118, green: 0.8235294118, blue: 0.6117647059, alpha: 1)
        UINavigationBar.appearance().isTranslucent = false
    }

}
