//
//  Public+Funcations.swift
//  CarTender
//
//  Created by R@NJ!T on 12/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//

import UIKit

// Public Functions

public func GET_DIRECTORY_PATH() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory + "/"
}

public func SAVE_IMAGE_IN_DIRECTORY(directoryname:String? = nil, chosenImage: UIImage,filename:String){
    var directoryPath: String =  GET_DIRECTORY_PATH()
    if directoryname != nil {
        directoryPath =  (GET_DIRECTORY_PATH()).appending("\(directoryname!)")
    }
    if !FileManager.default.fileExists(atPath: directoryPath) {
        do {
            try FileManager.default.createDirectory(at: NSURL.fileURL(withPath: directoryPath), withIntermediateDirectories: true, attributes: nil)
        } catch {
            print(error)
        }
    }
    let filepath = directoryPath.appending(filename)
    let url = NSURL.fileURL(withPath: filepath)
    do {
        try chosenImage.jpegRepresentationData?.write(to: url, options: .atomic)

    } catch {
        print("file cant not be save at path \(filepath), with error : \(error)")
    }
}

public func GET_IMAGE_FROM_DIRECTORY(imageName : String)-> UIImage?{
    let fileManager = FileManager.default
    // Here using getDirectoryPath method to get the Directory path
    let imagePath: String = GET_DIRECTORY_PATH().appending(imageName)
    if fileManager.fileExists(atPath: imagePath){
        return UIImage(contentsOfFile: imagePath)
    }else{
        print("No Image available")
        return nil // Return placeholder image here
    }
}
