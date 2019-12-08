//
//  OpenUrlViewController.swift
//  NewsApp
//
//  Created by David Phillips on 5/12/19.
//  Copyright © 2019 David Phillips. All rights reserved.
//

import UIKit
import WebKit

class OpenUrlViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var urlString: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadUrl()
    }
    
    // Convert the URLString into a URL Object and load the URL in the webView.
    private func loadUrl() {
        if urlString != nil {
            if let url = URL.init(string: urlString!) {
                let request = URLRequest(url: url)
                self.webView.load(request)
            }
        }
    }
    

}
