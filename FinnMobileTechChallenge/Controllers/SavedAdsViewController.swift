//
//  SecondViewController.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/19/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import UIKit

class SavedAdsViewController: UIViewController {
    
    // MARK: - Instance Variables
    fileprivate let cellIdentifier = "adCell"
    private var ads = [Ad]()
    
    // MARK: - IB Outlets
    @IBOutlet weak var adCollectionView: UICollectionView!
    
    
    
}
// MARK: - View LifeCycle
extension SavedAdsViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        //TODO: Request saved ads from core data through adService
        ads = CoreData.loadAds()
        self.adCollectionView.reloadData()
    }
}

// MARK: - CollectionViewDelegate

extension SavedAdsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ad = ads[indexPath.row]
        let cell = adCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AdCollectionViewCell
        let saveButtonImage = adService.saveButtonToggle(saved: ad.saved)
        cell.adDescription.text = ad.description
        cell.adLocation.text = ad.location
        cell.adPrice.text = adService.priceChecker(string: ad.price)
        cell.adImage.image = UIImage(data: ad.imageData as! Data)
        cell.saveButton.setImage(saveButtonImage, for: .normal)
        
        return cell
    }
}



