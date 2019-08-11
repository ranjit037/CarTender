//
//  WSGetSellingListResult.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 11, 2019

import Foundation


class WSGetSellingListResult : NSObject, NSCoding{

    var isnext : String?
    var sellingList : [WSSellingList]?


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        isnext = dictionary["isnext"] as? String
        sellingList = [WSSellingList]()
        if let sellingListArray = dictionary["sellingList"] as? [[String:Any]]{
            for dic in sellingListArray{
                let value = WSSellingList(fromDictionary: dic)
                sellingList?.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if isnext != nil{
            dictionary["isnext"] = isnext
        }
        if sellingList != nil{
            var dictionaryElements = [[String:Any]]()
            for sellingListElement in sellingList! {
                dictionaryElements.append(sellingListElement.toDictionary())
            }
            dictionary["sellingList"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        isnext = aDecoder.decodeObject(forKey: "isnext") as? String
        sellingList = aDecoder.decodeObject(forKey: "sellingList") as? [WSSellingList]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if isnext != nil{
            aCoder.encode(isnext, forKey: "isnext")
        }
        if sellingList != nil{
            aCoder.encode(sellingList, forKey: "sellingList")
        }
    }
}
