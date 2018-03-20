//
//  NetworkingProvider.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/19/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkingProvider {

    typealias RequestCompletion = ((Any?, Any?) -> Void)

    static func request(router: NetworkingRouter, completionHandler: @escaping (RequestCompletion)) {
        Alamofire.request(router.baseURL, method: router.method, headers: router.headers).validate().responseJSON() { response in
            
            //Since loading ads into collectionview cells is the first thing the user sees, loading the content gets top priority
            DispatchQueue.main.async {
                switch response.result{
                case .success(let value):
                    return completionHandler(value, response.result.error)

                case .failure:
                    if let error = response.result.error {
                        print(error)
                    }
                }
            }
        }
    }


}
