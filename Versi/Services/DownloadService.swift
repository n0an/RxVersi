//
//  DownloadService.swift
//  Versi
//
//  Created by nag on 22/09/2017.
//  Copyright © 2017 Anton Novoselov. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

class DownloadService {
    static let instance = DownloadService()
    
    private func downloadTrendingReposDictArray(completion: @escaping (_ reposDictArray: [JSON]) -> ()) {
        
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
                // !!!IMPORTANT!!!
                // How to parse in depth JSON, asynchronously reposArray filling in this scope, when filled - give filled array to completion
                self.parseRepo(fromDictionary: dict, completion: { (repo) in
                    if reposArray.count < 9 {
                        reposArray.append(repo)
                    } else {
                        let sortedArray = reposArray.sorted(by: { (repoA, repoB) -> Bool in
                            return repoA.numberOfForks > repoB.numberOfForks
                        })
                        completion(sortedArray)
                    }
                })
            }
        }
    }
    
    func parseRepo(fromDictionary dict: JSON, completion: @escaping (_ repo: Repo)->()) {
        
        let avatarUrlString      = dict["owner"]["avatar_url"].stringValue
        let name                 = dict["name"].stringValue
        let description          = dict["description"].stringValue
        let numberOfForks        = dict["forks_count"].intValue
        let language             = dict["language"].stringValue
        let contributorsUrl      = dict["contributors_url"].stringValue
        let repoUrl              = dict["html_url"].stringValue
        
        downloadImageFor(avatarUrl: avatarUrlString) { (returnedImage) in
            self.downloadContributorsDataFor(contributorsUrl: contributorsUrl, completion: { (contributorsCount) in
                
                let repo = Repo(image: returnedImage, name: name, description: description, numberOfForks: numberOfForks, language: language, numberOfContributors: contributorsCount, repoUrl: repoUrl)
                
                completion(repo)
            })
        }
        
    }
    
    
    func downloadImageFor(avatarUrl: String, completion: @escaping (_ image: UIImage)->()) {
        Alamofire.request(avatarUrl).responseImage { (imageResponse) in
            guard let image = imageResponse.result.value else { return }
            completion(image)
        }
    }
    
    func downloadContributorsDataFor(contributorsUrl: String, completion: @escaping (_ contributors: Int)->()) {
        
        Alamofire.request(contributorsUrl).responseJSON { (response) in
            
            guard let responseValue = response.result.value else { return }
            
            let json = JSON(responseValue)
        
            if !json.isEmpty {
                completion(json.count)
            }
            
        }
        
    }
    
    
}









