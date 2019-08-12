//
//  Constants_Web.swift
//  CarTender
//
//  Created by R@NJ!T on 11/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

let Server_URL = "http://push.cartradernow.com/"
//let MEDIA_URL = "\(Server_URL)/"

//HEADER KEYS
let CONTENT_TYPE = "content-type"

enum ServiceType:String {
    case GET = "GET"
    case POST = "POST"
    case JSON = "JSON"
}

enum RESPONSE_KEYS: String {
    case RESULT_KEY = "GetSellingListResult"
}

enum API_ERROR: String{
    case UNKNOWN = "Unknown error."
    case TRY_AGAIN = "Please try again later."
}

public enum WSRequestType : Int {
    case GetSellingList
}


struct WebServicePrefix
{
    static let WS_PATH = "CarTrader/CarTrader_Service.svc/"

    static func GetWSUrl(serviceType :WSRequestType) -> String
    {
        var serviceURl: NSString?
        switch serviceType
        {
        case .GetSellingList:
            serviceURl = "GetSellingList"
        }
        return "\(Server_URL)\(WS_PATH)\(serviceURl!)"
    }
}


//MARK:- Public Funcation
public func GET_ADDRESS_FROM_CLLOCATION(coordinate: CLLocation, responseData:@escaping (_ coordinate:CLLocation ,_ address:String) -> Void) {

    let geocoder = CLGeocoder()

    geocoder.reverseGeocodeLocation(coordinate) { response, error in
        var result = "Unknown address."
        if let address = response?.first {
            result = address.compactAddress ?? ""
        }
        responseData(coordinate, result)
    }
}

