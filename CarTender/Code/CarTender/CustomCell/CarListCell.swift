//
//  CarListCell.swift
//  CarTender
//
//  Created by R@NJ!T on 11/08/19.
//  Copyright © 2019 R@NJ!T. All rights reserved.
//

import UIKit

class CarListCell: UITableViewCell {

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
    
}

//MARK:- UICollectionViewDelegate and UICollectionViewDataSource
extension CarListCell: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idImageListCell, for: indexPath) as! ImageListCell

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
