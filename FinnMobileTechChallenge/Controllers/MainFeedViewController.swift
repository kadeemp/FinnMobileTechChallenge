//
//  FirstViewController.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/19/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import UIKit

class MainFeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingProvider.request(router: NetworkingRouter.getAds(), completionHandler: {_ in })
        // Do any additional setup after loading the view, typically from a nib.
    }



}

