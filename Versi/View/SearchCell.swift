//
//  SearchCell.swift
//  Versi
//
//  Created by nag on 22/09/2017.
//  Copyright © 2017 Anton Novoselov. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var repoDescLbl: UILabel!
    @IBOutlet weak var forksCountLbl: UILabel!
    @IBOutlet weak var repoLanguageLbl: UILabel!
    @IBOutlet weak var backView: UIView!
    
    public private(set) var repoUrl: String?

    func configureCell(repo: Repo) {
        repoImageView.image = repo.image
        repoNameLbl.text = repo.name
        repoDescLbl.text = repo.description
        forksCountLbl.text = String(repo.numberOfForks)
        repoLanguageLbl.text = repo.language
        
        repoUrl = repo.repoUrl
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 15
    }

}






