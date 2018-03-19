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

    typealias RequestCompletion = (((Any?, NSError?)?) -> Void)

    static func request(router: NetworkingRouter, completionHandler: @escaping (RequestCompletion)) {
        Alamofire.request(router.baseURL, method: router.method, parameters:router.parameters, headers: router.headers).validate().responseJSON() { response in
            DispatchQueue.main.async {
                switch response.result{
                case .success:
                    if let value = response.result.value {
                        print(value)
                    }
                case .failure:
                    if let error = response.result.error {
                        fatalError("Error retrieving Data")
                    }
                }
            }
        }
    }


}
