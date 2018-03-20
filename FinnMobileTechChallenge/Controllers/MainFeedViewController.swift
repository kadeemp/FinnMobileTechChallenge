//
//  FirstViewController.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/19/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import UIKit


class MainFeedViewController: UIViewController {


    // MARK: - Instance Variables
    fileprivate let cellIdentifier = "adCell"
    private var ads = [Ad]()

    // MARK: - IB Outlets
    @IBOutlet weak var adCollectionView: UICollectionView!

}

// MARK: - View LifeCycle
extension MainFeedViewController {

    override func viewWillAppear(_ animated: Bool) {
        _ = adService.loadAds { [weak self] allAds in
            guard let strongSelf = self else { return }
            strongSelf.ads = allAds
            strongSelf.adCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}



extension MainFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ad = ads[indexPath.row]
        let cell = adCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AdCollectionViewCell
        let image = adService.loadImage(imageURL: ad.imageURL)
        cell.adDescription.text = ad.description
        cell.adLocation.text = ad.location
        cell.adPrice.text = String(ad.price)
        cell.adImage.image = image
        return cell
    }



}

