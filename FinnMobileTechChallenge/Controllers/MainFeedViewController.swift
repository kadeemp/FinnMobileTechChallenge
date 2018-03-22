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
    private var savedAds = [Ad]()
    private var adsHolder = [Ad]()
    private var adsToggled = false

    // MARK: - IB Outlets
    @IBOutlet weak var adCollectionView: UICollectionView!
    @IBOutlet weak var savedAdsToggleButton: UIBarButtonItem!
    
    // MARK: - IB Actions

    @IBAction func toggleMainFeed(_ sender: Any) {

        if adsToggled == false {
            adsHolder = ads
            ads = savedAds
            adsToggled = true
            adCollectionView.reloadData()
        }
        else if adsToggled == true {
            ads = adsHolder
            adsToggled = false
            adCollectionView.reloadData()

        }
            }
}

// MARK: - View LifeCycle
extension MainFeedViewController {

    override func viewWillAppear(_ animated: Bool) {
        self.title = "Oppdage"
        savedAds = adService.loadKeys()
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
        let saveButtonImage = adService.isSavedButtonToogle(saved: ad.saved)
        cell.adDescription.text = ad.description
        cell.adLocation.text = ad.location
        cell.adPrice.text = adService.priceChecker(string: ad.price)
        if ad.imageData == nil {
            cell.adImage.af_setImage(withURL: adService.imageURLConverter(imageUrlPath: ad.imageURL))
        }
        else {
            cell.adImage.image = UIImage(data: ad.imageData! as Data)
        }

        cell.saveButton.setImage(saveButtonImage, for: .normal)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ad = ads[indexPath.row]
        if ad.imageData == nil {
            adService.downloadAdImage(ad: ad, imageUrlString: (FinnAPI.imageBaseURL + ad.imageURL), completion: {
                image in
                let imageData = UIImageJPEGRepresentation(image, 1) as! NSData
                ad.imageData = imageData
             //   print(ad.imageData!)
            })
        }
     //   print(ad.imageData)
        let cell = adCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AdCollectionViewCell
        ad.saved = adService.toggleSave(saved: ad.saved, ad:ad, index:indexPath.row)
        adCollectionView.reloadData()

    }
}






