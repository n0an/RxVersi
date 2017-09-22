//
//  Constants.swift
//  Versi
//
//  Created by nag on 22/09/2017.
//  Copyright © 2017 Anton Novoselov. All rights reserved.
//

import UIKit

// MARK – Colors
let lightPurple: UIColor = #colorLiteral(red: 0.4509803922, green: 0.4666666667, blue: 0.6862745098, alpha: 1)
let accentLightPurple: UIColor = #colorLiteral(red: 0.5254901961, green: 0.5294117647, blue: 0.7411764706, alpha: 1)
let darkPurple: UIColor = #colorLiteral(red: 0.2980392157, green: 0.3137254902, blue: 0.4666666667, alpha: 1)

// MARK – URLs
let trendingRepoUrl = "https://api.github.com/search/repositories?q=Swift&sort=stars&order=desc"
let searchUrl = "https://api.github.com/search/repositories?q="
let readmeSegment = "/blob/master/README.md"

// MARK – Notifications
let kNotificationReloadAllData = NSNotification.Name("reloadAllData")

