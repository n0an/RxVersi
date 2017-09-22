//
//  DownloadService.swift
//  Versi
//
//  Created by nag on 22/09/2017.
//  Copyright © 2017 Anton Novoselov. All rights reserved.
//

import Foundation
import Alamofire

class DownloadService {
    static let instance = DownloadService()
    
    func downloadTrendingReposDictArray(completion: @escaping (_ reposDictArray: [String: Any])->()) {
        
        Alamofire.request(trendingRepoUrl).responseJSON { (response) in
            
            
            
            
        }
        
    }
    
    
    
}

