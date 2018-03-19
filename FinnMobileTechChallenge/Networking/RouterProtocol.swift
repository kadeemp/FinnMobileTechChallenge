//
//  RouterProtocol.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/19/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import Foundation
import Alamofire

protocol RouterProtocol {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: [String:Any]? { get }
}
