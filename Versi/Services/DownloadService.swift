//
//  DownloadService.swift
//  Versi
//
//  Created by nag on 22/09/2017.
//  Copyright © 2017 Anton Novoselov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DownloadService {
    static let instance = DownloadService()
    
    func downloadTrendingReposDictArray(completion: @escaping (_ reposDictArray: [JSON]) -> ()) {
        
        var trendingReposArray = [JSON]()
        
        Alamofire.request(trendingRepoUrl).responseJSON { (response) in
            
            guard let jsonResponse = response.result.value as? [String: Any] else { return }
            
            let json = JSON(jsonResponse)
            
            let repoDictArr = json["items"].arrayValue
            
            for repoDict in repoDictArr {
                if trendingReposArray.count <= 10 {
                    trendingReposArray.append(repoDict)
                } else {
                    break
                }
            }
            
            completion(trendingReposArray)
            
            
        }
        
    }
    
}

