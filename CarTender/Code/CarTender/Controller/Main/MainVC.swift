//
//  ViewController.swift
//  CarTender
//
//  Created by R@NJ!T on 10/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainVC: BaseVC {

    //Variables
    var currentPageIndex = 1
    var nextAvaialable = true

    // outlets
    @IBOutlet weak var vwStausbar:UIView!
    @IBOutlet weak var tblCarList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblCarList.delegate = self
        tblCarList.dataSource = self
        tblCarList.register(UINib(nibName: xibCarListHeaderCell, bundle: nil), forCellReuseIdentifier: idCarListHeaderCell)
        tblCarList.register(UINib(nibName: xibCarListCell, bundle: nil), forCellReuseIdentifier: idCarListCell)
        self.callGetSellingListAPI(showloader: true)
    }


}

//MARK:- UITableViewDelegate and UITableViewDataSource
extension MainVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let cell = tableView.dequeueReusableCell(withIdentifier: idCarListHeaderCell) as? CarListHeaderCell {
            
            return cell
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: idCarListCell, for: indexPath) as? CarListCell {
            
            return cell
        }
        return UITableViewCell()
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
            let subParam:NSDictionary = [
                "latitude":"23.0122",
                "longitude":"72.122",
                "pageIndex":"\(currentPageIndex)",
                "pageSize":"10",
                "sorttype":"-1"
            ]
            let param:NSDictionary = ["request": subParam]
            let headers = [
                CONTENT_TYPE:"application/json"
            ]
 
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
                                    }
                                }
                            }
                            else {
                                print("error")
                            }

                        }
                        break
                    case .failure(let error):
                        print(response.result.error as NSError?,API_ERROR.TRY_AGAIN.rawValue)
                        break
                    }

                }
//                .responseString { response in
//                    print("Response String:\(String(describing: response.result.value))")
//            }
        }
        if showloader {
            NIPLProgressHUD.show()
        }


    }

}
