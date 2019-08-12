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
    let realm = try? Realm()

    // outlets
    @IBOutlet weak var vwStausbar:UIView!
    @IBOutlet weak var tblCarList: UITableView!
    @IBOutlet weak var tblFooterView: UIView!
    @IBOutlet weak var spinnerIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lblLoadMore: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tblCarList.delegate = self
        tblCarList.dataSource = self
        tblCarList.register(UINib(nibName: xibCarListHeaderCell, bundle: nil), forCellReuseIdentifier: idCarListHeaderCell)
        tblCarList.register(UINib(nibName: xibCarListCell, bundle: nil), forCellReuseIdentifier: idCarListCell)
        tblCarList.tableFooterView = self.tblFooterView

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.updateCurrentLocation),
                                               name: NSNotification.Name(rawValue: NC_UPDATE_CURRENT_LOCATION),
                                               object: nil)



        print(Realm.Configuration.defaultConfiguration.fileURL!)
        self.callGetSellingListAPI()
        
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
                cell.setupCell(objData: data)
                return cell
            }
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (self.sellingLists?.count ?? 0) - 1 {
            self.callGetSellingListAPI()
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

    func callGetSellingListAPI() {

        if(NetworkReachabilityManager()?.isReachable ?? false)
        {
            if nextAvaialable {

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
                                                        for objValue in valueImages {
                                                            newSellingList.imagelists.append(ImageList(value: ["parent_id":newSellingList.id,"imageName": objValue]))
                                                        }
                                                    }

                                                    if let valueVideo = objSelling.videolist {
                                                        for objValue in valueVideo {
                                                            newSellingList.videolist.append(VideoList(value: ["parent_id":newSellingList.id,"videoName": objValue]))
                                                        }
                                                    }
                                                    arrSellingList.append(newSellingList)
                                                }

                                                if arrSellingList.count > 0 {
                                                    do {
                                                        try self.realm?.write({ () -> Void in
                                                            self.realm?.add(arrSellingList, update: .modified)
                                                        })
                                                    }
                                                    catch let error as NSError {
                                                        print(error.localizedDescription)
                                                    }

                                                }
                                                self.sellingLists = self.realm?.objects(SellingList.self)
                                                DispatchQueue.main.async {
                                                    self.tblCarList.reloadData()
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
                                self.sellingLists = self.realm?.objects(SellingList.self)
                                DispatchQueue.main.async {
                                    self.tblCarList.reloadData()
                                }

                                break
                            }

                    }
                }

            }
        }
        else {
            self.sellingLists = self.realm?.objects(SellingList.self)
            self.tblCarList.reloadData()
        }
    }
}
