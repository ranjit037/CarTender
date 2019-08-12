//
//  CLPlacemark+Extension.swift
//  CarTender
//
//  Created by R@NJ!T on 12/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//

import Foundation
import CoreLocation

extension CLPlacemark {

    var compactAddress: String? {
        if let name = name {
            var result = name

            if let subLocality = subLocality {
                result += ", \(subLocality)"
            }
            if let city = locality {
                result += ", \(city)"
            }
            if let postalCode = postalCode {
                result += ", \(postalCode)"
            }
            if let country = country {
                result += ", \(country)."
            }

            return result
        }

        return nil
    }

}
