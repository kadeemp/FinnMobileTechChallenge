//
//  FirstViewController.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/19/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import UIKit
import AlamofireImage

class MainFeedViewController: UIViewController {


    // MARK: - Instance Variables
    fileprivate let cellIdentifier = "adCell"
    private var ads = [Ad]()

    // MARK: - IB Outlets
    @IBOutlet weak var adCollectionView: UICollectionView!
    @IBOutlet weak var savedAdsToggleButton: UIBarButtonItem!
    // MARK: - IB Actions

    @IBAction func toggleMainFeed(_ sender: Any) {
    }
}

// MARK: - View LifeCycle
extension MainFeedViewController {

    override func viewWillAppear(_ animated: Bool) {
        self.title = "Oppdage"

        _ = adService.loadAds { [weak self] allAds in
            guard let strongSelf = self else { return }
            strongSelf.ads = allAds
            strongSelf.adCollectionView.reloadData()
        }

    }
}

// MARK: - CollectionViewDelegate
extension MainFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ad = ads[indexPath.row]
        let cell = adCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AdCollectionViewCell

        cell.adDescription.text = ad.description
        cell.adLocation.text = ad.location
        cell.adPrice.text = adService.priceChecker(string: ad.price)
        cell.adImage.af_setImage(withURL: adService.imageURLConverter(imageUrlPath: ad.imageURL))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ad = ads[indexPath.row]
        let cell = adCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AdCollectionViewCell
     //image from cell returns nil. so far can't save from here
    }
}






