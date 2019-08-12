//
//  WSSellingList.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 11, 2019

import Foundation


class WSSellingList : NSObject, NSCoding{

    var distance : String?
    var id : Int?
    var imagelist : [String]?
    var make : String?
    var miles : String?
    var model : String?
    var price : String?
    var shareurl : String?
    var status : String?
    var videolist : [String]?
    var year : String?


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        distance = dictionary["distance"] as? String
        id = dictionary["id"] as? Int
        make = dictionary["make"] as? String
        miles = dictionary["miles"] as? String
        model = dictionary["model"] as? String
        price = dictionary["price"] as? String
        shareurl = dictionary["shareurl"] as? String
        status = dictionary["status"] as? String
        year = dictionary["year"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if distance != nil{
            dictionary["distance"] = distance
        }
        if id != nil{
            dictionary["id"] = id
        }
        if make != nil{
            dictionary["make"] = make
        }
        if miles != nil{
            dictionary["miles"] = miles
        }
        if model != nil{
            dictionary["model"] = model
        }
        if price != nil{
            dictionary["price"] = price
        }
        if shareurl != nil{
            dictionary["shareurl"] = shareurl
        }
        if status != nil{
            dictionary["status"] = status
        }
        if year != nil{
            dictionary["year"] = year
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        distance = aDecoder.decodeObject(forKey: "distance") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        imagelist = aDecoder.decodeObject(forKey: "imagelist") as? [String]
        make = aDecoder.decodeObject(forKey: "make") as? String
        miles = aDecoder.decodeObject(forKey: "miles") as? String
        model = aDecoder.decodeObject(forKey: "model") as? String
        price = aDecoder.decodeObject(forKey: "price") as? String
        shareurl = aDecoder.decodeObject(forKey: "shareurl") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        videolist = aDecoder.decodeObject(forKey: "videolist") as? [String]
        year = aDecoder.decodeObject(forKey: "year") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if distance != nil{
            aCoder.encode(distance, forKey: "distance")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if imagelist != nil{
            aCoder.encode(imagelist, forKey: "imagelist")
        }
        if make != nil{
            aCoder.encode(make, forKey: "make")
        }
        if miles != nil{
            aCoder.encode(miles, forKey: "miles")
        }
        if model != nil{
            aCoder.encode(model, forKey: "model")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if shareurl != nil{
            aCoder.encode(shareurl, forKey: "shareurl")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if videolist != nil{
            aCoder.encode(videolist, forKey: "videolist")
        }
        if year != nil{
            aCoder.encode(year, forKey: "year")
        }
    }
}
