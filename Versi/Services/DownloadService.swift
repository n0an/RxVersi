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
                if trendingReposArray.count < 10 {
                    trendingReposArray.append(repoDict)
                } else {
                    break
                }
            }
            completion(trendingReposArray)
        }
    }
    
    func downloadTrendingRepos(completion: @escaping (_ reposArray: [Repo]) -> ()) {
        downloadTrendingReposDictArray { (trendingReposDictArray) in
            var reposArray = [Repo]()
            
            for dict in trendingReposDictArray {
                let repo = self.parseTrendingRepo(fromDictionary: dict)
                reposArray.append(repo)
            }
            
            completion(reposArray)
        }
    }
    
    func parseTrendingRepo(fromDictionary dict: JSON) -> Repo {
        
        let avatarUrlString      = dict["avatar_url"].stringValue
        let name                 = dict["name"].stringValue
        let description          = dict["description"].stringValue
        let numberOfForks        = dict["forks_count"].intValue
        let language             = dict["language"].stringValue
        let numberOfContributors = 100 // dummy
        let repoUrl              = dict["html_url"].stringValue
        
        let repo = Repo(image: #imageLiteral(resourceName: "searchIconLarge"), name: name, description: description, numberOfForks: numberOfForks, language: language, numberOfContributors: numberOfContributors, repoUrl: repoUrl)
        
        return repo
    }
    
}









