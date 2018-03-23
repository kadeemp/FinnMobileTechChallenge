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

        toggleMainFeed()
    }
}

// MARK: - View LifeCycle
extension MainFeedViewController {

    override func viewWillAppear(_ animated: Bool) {

        self.title = "Funksjoner Annonser"
        savedAds = CoreData.loadAds()
        _ = adService.loadAds { [weak self] allAds in
            guard let strongSelf = self else { return }
            strongSelf.ads = allAds
            adService.adChecker(ads: strongSelf.ads, titles: CoreData.loadAdTitles())
            strongSelf.adCollectionView.reloadData()
        }
        loadSavedAds()

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
        let saveButtonImage = adService.saveButtonToggle(saved: ad.saved)
        cell.adDescription.text = ad.description
        cell.adLocation.text = ad.location
        cell.adPrice.text = adService.priceChecker(string: ad.price)
        if ad.imageData == nil {
            cell.adImage.af_setImage(withURL: adService.imageURLConverter(imageUrlPath: ad.imageURL))
        } else {
            cell.adImage.image = UIImage(data: ad.imageData! as Data)
        }
        cell.saveButton.setImage(saveButtonImage, for: .normal)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ad = ads[indexPath.row]
        loadImageData(ad: ad)
        ad.saved = adService.toggleSave(ad:ad)
        adCollectionView.reloadData()

    }
}
extension MainFeedViewController {

    func loadImageData(ad:Ad) {
        if ad.imageData == nil {
            adService.downloadAdImage(ad: ad, imageUrlString: (FinnAPI.imageBaseURL + ad.imageURL), completion: { image in
                let imageData = UIImageJPEGRepresentation(image, 1)! as NSData
                ad.imageData = imageData
            })
        }
    }
    
    func loadSavedAds() {
        if ads.count == 0 {
            ads = savedAds
            adCollectionView.reloadData()

        }
    }

    func toggleMainFeed() {
        if adsToggled == false {
            adsHolder = adService.unSavedAdSeperator(ads: ads)
            ads = CoreData.loadAds()
            adsToggled = true
            adCollectionView.reloadData()
            self.title = "Lagrede Annonser"
        }
        else if adsToggled == true {
            for ad in ads {
                adsHolder.insert(ad, at: 0)
            }
            ads = adsHolder
            adsToggled = false
            adCollectionView.reloadData()
            self.title = "Funksjoner Annonser"

        }
    }

    //MARK:- Bugs
    /*When you remove an ad from being saved from
     the saved ads collectionView, It doesn't update
     the data in the featured ads section*/
}





