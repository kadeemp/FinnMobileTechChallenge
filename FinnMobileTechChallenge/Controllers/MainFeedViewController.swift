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

        _ = adService.loadAds { [weak self] allAds in
            guard let strongSelf = self else { return }
            strongSelf.ads = allAds
            strongSelf.ads = (self?.alphabeticalLocationSort(adArray: (self?.ads)!))!
            adService.adChecker(ads: strongSelf.ads, titles: CoreData.loadAdTitles())
            strongSelf.adCollectionView.reloadData()
        }
        savedAds = CoreData.loadAds()
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
        let saveButtonImage = adService.saveButtonToggle(saved: ad.saved)
        let cell = adCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AdCollectionViewCell

        cell.adDescription.text = ad.description
        cell.adLocation.text = ad.location
        cell.adPrice.text = adService.priceChecker(string: ad.price)
        cell.saveButton.setImage(saveButtonImage, for: .normal)
        if ad.imageData == nil {
            cell.adImage.af_setImage(withURL: adService.imageURLConverter(imageUrlPath: ad.imageURL))
        } else {
            cell.adImage.image = UIImage(data: ad.imageData! as Data)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        var ad = ads[indexPath.row]
        ad.saved = adService.toggleSave(ad:ad)
        adCollectionView.reloadData()
        
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {

        let cell: AdCollectionViewCell = adCollectionView.cellForItem(at: indexPath) as! AdCollectionViewCell
        cell.adDescription.textColor = UIColor(red: 123/255, green: 182/255, blue: 210/255, alpha: 1.0)
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {

        let cell: AdCollectionViewCell = adCollectionView.cellForItem(at: indexPath) as! AdCollectionViewCell
        cell.adDescription.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }
}

extension MainFeedViewController {

    func loadSavedAds() {

        if ads.count == 0 {
            ads = savedAds
            adCollectionView.reloadData()
        }
    }
    func alphabeticalLocationSort(adArray:[Ad]) -> [Ad] {

        var sortedArray:[Ad] = []
        sortedArray = adArray.sorted(by: { $0.location.compare($1.location) == .orderedAscending })
        return sortedArray
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
                adsHolder.append(ad)
            }
            ads = adsHolder
            ads = alphabeticalLocationSort(adArray: ads)
            adsToggled = false
            adCollectionView.reloadData()
            self.title = "Funksjoner Annonser"
        }
    }
    
}





