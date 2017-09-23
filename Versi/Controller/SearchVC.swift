//
//  SearchVC.swift
//  Versi
//
//  Created by nag on 22/09/2017.
//  Copyright © 2017 Anton Novoselov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON

class SearchVC: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var searchBar: RoundedBorderTextField!
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindElements()
        
        tableView.rx.setDelegate(self).addDisposableTo(disposeBag)
        
    }

    func bindElements() {
        let searchResultsObservable = searchBar.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .map {
                $0.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
                
            }
            .flatMap { (query) -> Observable<[Repo]> in
                if query == "" {
                    return Observable<[Repo]>.just([])
                } else {
                    let url = searchUrl + query + starDescendingSegment
                    
                    var searchRepos = [Repo]()
                    
                    return URLSession.shared.rx.json(url: URL(string: url)!).map {
                        
                        let json = JSON($0)
                        
                        let items = json["items"].arrayValue
                        
                        for item in items {
                            let name = item["name"].stringValue
                            let description = item["description"].stringValue
                            let language = item["language"].stringValue
                            let forksCount = item["forks_count"].intValue
                            let repoUrl = item["html_url"].stringValue
                            
                            let repo = Repo(image: #imageLiteral(resourceName: "searchIconLarge"), name: name, description: description, numberOfForks: forksCount, language: language, numberOfContributors: 0, repoUrl: repoUrl)
                            
                            searchRepos.append(repo)
                        }
                        
                        return searchRepos
                    }
                }
            }
            .observeOn(MainScheduler.instance)
        
        searchResultsObservable.bind(to: tableView.rx.items(cellIdentifier: "searchCell")) {
            (row, repo: Repo, cell: SearchCell) in
            
            cell.configureCell(repo: repo)
            
        }.addDisposableTo(disposeBag)
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchCell else {
            return
        }
        
        let url = cell.repoUrl!
        self.presentSafariWebViewFor(url: url)
        
        print(cell.repoUrl)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}






