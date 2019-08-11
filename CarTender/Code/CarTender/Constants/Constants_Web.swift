//
//  Constants_Web.swift
//  CarTender
//
//  Created by R@NJ!T on 11/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//

import Foundation
import UIKit


let Server_URL = "http://push.cartradernow.com/"
//let MEDIA_URL = "\(Server_URL)users_images/"

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

/*
func GET_IMAGE_FROM_WEB(_ urlString: String, closure: @escaping (UIImage?) -> ()) {
    guard let url = URL(string: urlString) else {
        return closure(nil)
    }
    let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
        guard error == nil else {
            print("error: \(String(describing: error))")
            return closure(nil)
        }
        guard response != nil else {
            print("no response")
            return closure(nil)
        }
        guard data != nil else {
            print("no data")
            return closure(nil)
        }
        DispatchQueue.main.async {
            closure(UIImage(data: data!))
        }
    }; task.resume()
}

func SAVE_FILE_FROM_WEB(_ urlString: String,directoryName:String, closure: @escaping (Bool,String) -> ()) {

    guard let servalUrl = URL(string: urlString) else {
        return closure(true, "Not a valid url.")
    }

    let sessionConfig = URLSessionConfiguration.default
    let session = URLSession(configuration: sessionConfig)
    let request = try! URLRequest(url: servalUrl, method: .get)

    let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
        if let tempLocalUrl = tempLocalUrl, error == nil {
            // Success
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                print("Success: \(statusCode)")
            }
            let directoryPath: String =  (GET_DIRECTORY_PATH()).appending("\(directoryName)/")
            if !FileManager.default.fileExists(atPath: directoryPath) {
                do {
                    try FileManager.default.createDirectory(at: NSURL.fileURL(withPath: directoryPath), withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print(error)
                }
            }
            let filepath = directoryPath.appending("account_info.zip")
            let localFileUrl = NSURL.fileURL(withPath: filepath)

            do {
                try FileManager.default.copyItem(at: tempLocalUrl, to: localFileUrl)
                closure(false, "File sucessfuly saved.")
            } catch (let writeError) {
                closure(true,"error writing file \(directoryName) : \(writeError)")
            }

        } else {
            closure(true,"Failure: %@ \(String(describing: error?.localizedDescription))")
        }
    }
    task.resume()
}

func GET_IMAGEDATA_FROM_WEB(_ urlString: String, closure: @escaping (Data?) -> ()) {
    guard let url = URL(string: urlString) else {
        return closure(nil)
    }
    let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
        guard error == nil else {
            print("error: \(String(describing: error))")
            return closure(nil)
        }
        guard response != nil else {
            print("no response")
            return closure(nil)
        }
        guard data != nil else {
            print("no data")
            return closure(nil)
        }
        DispatchQueue.main.async {
            closure(data)
        }
    }; task.resume()
}
*/
