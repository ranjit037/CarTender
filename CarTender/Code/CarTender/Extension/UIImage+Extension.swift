//
//  UIImage+Extension.swift
//  CarTender
//
//  Created by R@NJ!T on 12/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//

import UIKit

extension UIImage {

    var jpegRepresentationData: Data? {
        return self.jpegData(compressionQuality:1.0)
    }
}
