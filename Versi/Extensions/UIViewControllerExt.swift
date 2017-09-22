//
//  UIViewController+presentSafariWebView.swift
//  Versi
//
//  Created by nag on 22/09/2017.
//  Copyright © 2017 Anton Novoselov. All rights reserved.
//

import Foundation
import SafariServices

extension UIViewController {
    func presentSafariWebViewFor(url: String) {
        let repoUrl = URL(string: url + readmeSegment)
        let safariVC = SFSafariViewController(url: repoUrl!)
        present(safariVC, animated: true, completion: nil)
    }
}

