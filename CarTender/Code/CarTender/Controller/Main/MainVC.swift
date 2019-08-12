//
//  ViewController.swift
//  CarTender
//
//  Created by R@NJ!T on 10/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class MainVC: BaseVC {

    //Variables
    var currentPageIndex = 1
    var nextAvaialable = true
    var sellingLists : Results<SellingList>?
    var currentAddress = "Unknown address."

    // outlets
    @IBOutlet weak var vwStausbar:UIView!
    @IBOutlet weak var tblCarList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblCarList.delegate = self
        tblCarList.dataSource = self
        tblCarList.register(UINib(nibName: xibCarListHeaderCell, bundle: nil), forCellReuseIdentifier: idCarListHeaderCell)
        tblCarList.register(UINib(nibName: xibCarListCell, bundle: nil), forCellReuseIdentifier: idCarListCell)
        tblCarList.tableFooterView = UIView()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.updateCurrentLocation),
                                               name: NSNotification.Name(rawValue: NC_UPDATE_CURRENT_LOCATION),
                                               object: nil)



        print(Realm.Configuration.defaultConfiguration.fileURL!)
        self.callGetSellingListAPI(showloader: true)
        
    }

    @objc func updateCurrentLocation() {
        if let cl_location = APP_DELEGATE.objLocManager?.location {
            GET_ADDRESS_FROM_CLLOCATION(coordinate: cl_location, responseData: { (location, address) in
                self.currentAddress = address
                self.tblCarList.reloadData()
            })
        }
    }

}

//MARK:- UITableViewDelegate and UITableViewDataSource
extension MainVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sellingLists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let cell = tableView.dequeueReusableCell(withIdentifier: idCarListHeaderCell) as? CarListHeaderCell {
            cell.lblNearBy.text = "Near: " + self.currentAddress
            return cell
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: idCarListCell, for: indexPath) as? CarListCell {
            if let data = sellingLists?[indexPath.row] {
                cell.titleLables[0].text = "\(data.year) \(data.make)"
                cell.titleLables[1].text = data.model
                cell.titleLables[2].text = data.miles + " miles"
                cell.bottomLables[0].text = data.distance + " miles away"
                cell.bottomLables[1].text = " $" + data.price

                switch CAR_STATUS(rawValue:data.status) {
                case .none:
                    break
                case .some(let values):
                    switch values {
                    case .SOLD:
                        cell.bottomLables[1].backgroundColor = .red
                        break
                    case .UNSOLD:
                        cell.bottomLables[1].backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.8235294118, blue: 0.6117647059, alpha: 1)
                        break
                    }
                }

                return cell
            }
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (self.sellingLists?.count ?? 0) - 1 {
            self.callGetSellingListAPI(showloader: false)
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
}


//MARK:- API Calls
extension MainVC {

    func callGetSellingListAPI(showloader:Bool) {

        if nextAvaialable {

            if showloader {
                NIPLProgressHUD.show()
            }

            let latitude = APP_DELEGATE.objLocManager?.location?.coordinate.latitude ?? 23.0122
            let longitude = APP_DELEGATE.objLocManager?.location?.coordinate.longitude ?? 72.122

            let subParam:NSDictionary = [
                "latitude":latitude,
                "longitude":longitude,
                "pageIndex":"\(currentPageIndex)",
                "pageSize":"10",
                "sorttype":"-1"
            ]
            let param:NSDictionary = ["request": subParam]
            let headers = [
                CONTENT_TYPE:"application/json"
            ]

            DispatchQueue.global(qos: .background).async {
                Alamofire.SessionManager.default.request(WebServicePrefix.GetWSUrl(serviceType: WSRequestType.GetSellingList),
                                                         method: .post,
                                                         parameters: param as? Parameters,
                                                         encoding: JSONEncoding.default,
                                                         headers: headers)

                    .responseJSON { (response:DataResponse<Any>) in
                        NIPLProgressHUD.dismiss()
                        switch(response.result)
                        {
                        case .success(_):
                            if let data = response.result.value
                            {
                                if let responseDict = data as? [String : Any] {

                                    let respObj = WSBaseSellingList.init(fromDictionary: responseDict)
                                    if let result = respObj.getSellingListResult {
                                        if result.isnext.asStringOrEmpty(defaultValue: "0") == "0"  {
                                            self.nextAvaialable = false
                                        }
                                        if let sellingListData = result.sellingList {
                                            self.currentPageIndex += 1
                                            var arrSellingList = [SellingList]()

                                            for objSelling in sellingListData { // 4
                                                let newSellingList = SellingList()

                                                newSellingList.id = objSelling.id.aIntOrEmpty()
                                                newSellingList.distance = objSelling.distance.asStringOrEmpty()
                                                newSellingList.make = objSelling.make.asStringOrEmpty()
                                                newSellingList.miles = objSelling.miles.asStringOrEmpty()
                                                newSellingList.model = objSelling.model.asStringOrEmpty()
                                                newSellingList.price = objSelling.price.asStringOrEmpty()
                                                newSellingList.shareurl = objSelling.shareurl.asStringOrEmpty()
                                                newSellingList.status = objSelling.status.asStringOrEmpty()
                                                newSellingList.year = objSelling.year.asStringOrEmpty()

                                                if let valueImages = objSelling.imagelist {
                                                    var arrImageList = [ImageList]()
                                                    //                                                var newImageList = List<ImageList>()
                                                    for objValue in valueImages {
                                                        let wish1 = ImageList()
                                                        wish1.imageName = objValue
                                                        arrImageList.append(ImageList(value: ["imageName": objValue]))
                                                        //                                                    newImageList.append(ImageList(value: ["imageName": objValue]))
                                                    }

                                                    //                                                let img1 = ImageList()
                                                    //                                                img1.imageName = valueImages[0]
                                                    //                                                let img2 = ImageList()
                                                    //                                                img2.imageName = valueImages[1]

                                                    newSellingList.imagelists.append(objectsIn: arrImageList)
                                                }
                                                if let valueVideo = objSelling.videolist {
                                                    for objValue in valueVideo {
                                                        newSellingList.videolist.append(VideoList(value: ["videoName": objValue]))
                                                    }
                                                }

                                                arrSellingList.append(newSellingList)
                                            }

                                            if arrSellingList.count > 0 {
                                                do {

                                                    let realm = try Realm()
                                                    try realm.write({ () -> Void in
                                                        realm.add(arrSellingList, update: .modified)
                                                    })

                                                    DispatchQueue.main.async {
                                                        self.sellingLists = realm.objects(SellingList.self)
                                                        self.tblCarList.reloadData()
                                                    }
                                                }
                                                catch let error as NSError {
                                                    print(error.localizedDescription)
                                                }

                                            }
                                        }
                                    }
                                }
                                else {
                                    print("error")
                                }

                            }
                            break
                        case .failure(let error):
                            print(error.localizedDescription)
                            break
                        }

                }
            }

        }
    }

}
