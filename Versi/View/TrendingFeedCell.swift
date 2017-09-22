//
//  TrendingFeedCell.swift
//  Versi
//
//  Created by nag on 22/09/2017.
//  Copyright © 2017 Anton Novoselov. All rights reserved.
//

import UIKit

class TrendingFeedCell: UITableViewCell {
    
    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var repoDescLbl: UILabel!
    @IBOutlet weak var numberOfDownloadsLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var contributorsLbl: UILabel!
    @IBOutlet weak var backView: UIView!

    
    
    @IBAction func viewReadmeBtnWasPressed(_ sender: UITableViewCell) {
//        self.window?.rootViewController?.presentSafariWebViewFor(url: repoUrl!)
    }

}
