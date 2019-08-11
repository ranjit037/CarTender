//
//  WSBaseSellingList.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 11, 2019

import Foundation


class WSBaseSellingList : NSObject, NSCoding{

    var getSellingListResult : WSGetSellingListResult?


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let getSellingListResultData = dictionary["GetSellingListResult"] as? [String:Any]{
            getSellingListResult = WSGetSellingListResult(fromDictionary: getSellingListResultData)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if getSellingListResult != nil{
            dictionary["getSellingListResult"] = getSellingListResult!.toDictionary()
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        getSellingListResult = aDecoder.decodeObject(forKey: "GetSellingListResult") as? WSGetSellingListResult
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if getSellingListResult != nil{
            aCoder.encode(getSellingListResult, forKey: "GetSellingListResult")
        }
    }
}
