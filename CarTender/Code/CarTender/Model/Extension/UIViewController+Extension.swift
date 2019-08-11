//
//  UIViewController+Extension.swift
//  CarTender
//
//  Created by R@NJ!T on 10/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//

import UIKit

extension UIViewController{

    func alert(title:String?,message:String,okTitle:String,btnStyle : UIAlertAction.Style = .default, completion: (()->(Void))?) {

        let myAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: title, style: btnStyle) { (action) in
            completion?()
        }
        myAlert.addAction(action)

        self.present(myAlert, animated:true, completion:nil)
    }
}

