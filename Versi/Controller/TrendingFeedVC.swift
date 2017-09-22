//
//  TrendingFeedVC.swift
//  Versi
//
//  Created by nag on 22/09/2017.
//  Copyright © 2017 Anton Novoselov. All rights reserved.
//

import UIKit

class TrendingFeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

}

extension TrendingFeedVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trendingFeedCell", for: indexPath) as! TrendingFeedCell
        
        let image = #imageLiteral(resourceName: "searchIconLarge")
        
        let repo = Repo(image: image, name: "Test", description: "Test desc", numberOfForks: 10, language: "Swift", numberOfContributors: 20, repoUrl: "http://swift.org")
        
        cell.configureCell(repo: repo)
        
        return cell
        
    }
}

extension TrendingFeedVC: UITableViewDelegate {
    
}














