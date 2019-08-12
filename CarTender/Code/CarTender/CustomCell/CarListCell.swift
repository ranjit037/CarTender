//
//  CarListCell.swift
//  CarTender
//
//  Created by R@NJ!T on 11/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

class CarListCell: UITableViewCell {

    var carImageList : List<ImageList> = List<ImageList>()

    @IBOutlet weak var vwMain: UIView!
    @IBOutlet var titleLables: [UILabel]!
    @IBOutlet weak var collectionCarImages: UICollectionView!
    @IBOutlet var bottomLables: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionCarImages.delegate = self
        collectionCarImages.dataSource = self
        collectionCarImages.register(UINib(nibName: xibImageListCell, bundle: nil), forCellWithReuseIdentifier: idImageListCell)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(objData: SellingList) {

        titleLables[0].text = "\(objData.year) \(objData.make)"
        titleLables[1].text = objData.model
        titleLables[2].text = objData.miles + " miles"
        bottomLables[0].text = objData.distance + " miles away"
        bottomLables[1].text = " $" + objData.price

        switch CAR_STATUS(rawValue: objData.status) {
        case .none:
            break
        case .some(let values):
            switch values {
            case .SOLD:
                bottomLables[1].backgroundColor = .red
                break
            case .UNSOLD:
                bottomLables[1].backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.8235294118, blue: 0.6117647059, alpha: 1)
                break
            }
        }
        self.carImageList = objData.imagelists
        self.collectionCarImages.reloadData()
    }
    
}

//MARK:- UICollectionViewDelegate and UICollectionViewDataSource
extension CarListCell: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carImageList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idImageListCell, for: indexPath) as! ImageListCell

        let imageListData = carImageList[indexPath.row]

        cell.imgVWCar.sd_cancelCurrentImageLoad()
        if let image = GET_IMAGE_FROM_DIRECTORY(imageName: MEDIA_URL.LOCAL.rawValue + imageListData.imageName) {
//            cell.imgVWCar.sd_imageIndicator = nil
            cell.imgVWCar.image = image
        }
        else {
            cell.imgVWCar.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.imgVWCar.sd_setImage(with: URL(string: MEDIA_URL.SERVER.rawValue + "\(imageListData.parent_id)/\(imageListData.imageName)"),
                                      placeholderImage: #imageLiteral(resourceName: "carPlaceholderImage"),
                                      options: [.refreshCached]) { (img, err, cacheType, url) in
                                        if img != nil {
                                            SAVE_IMAGE_IN_DIRECTORY(directoryname: MEDIA_URL.LOCAL.rawValue,
                                                                    chosenImage: img!,
                                                                    filename: imageListData.imageName)
                                        }
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }

    override func prepareForReuse() {
        collectionCarImages.contentOffset = CGPoint(x: 0, y: 0)
    }
}
