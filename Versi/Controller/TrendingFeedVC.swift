//
//  TrendingFeedVC.swift
//  Versi
//
//  Created by nag on 22/09/2017.
//  Copyright © 2017 Anton Novoselov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingFeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    var dataSource = PublishSubject<[Repo]>()
    
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = refreshControl
        
        refreshControl.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Hot Github Repos 🔥", attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 16.0)!])
        
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)

        fetchData()
        
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "trendingFeedCell", cellType: TrendingFeedCell.self)) { (row, repo: Repo, cell: TrendingFeedCell) in
            
            cell.configureCell(repo: repo)
            
        }.addDisposableTo(disposeBag)
        
        
    }
    
    @objc func fetchData() {
        DownloadService.instance.downloadTrendingRepos { (reposArray) in
            self.dataSource.onNext(reposArray)
            self.refreshControl.endRefreshing()
        }
    }

}







