//
//  UrlViewController.swift
//  Foodie
//  Name: Carson Wang
//  Email: carsonw@usc.edu
//  Created by Carson Wang on 12/7/22.
//

import UIKit
import WebKit

// This is the webview for loading website for the resturants

class UrlViewController: UIViewController, WKNavigationDelegate {
    
    // outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get url
        let request = URLRequest(url: URL(string: ImagesViewController.shared.storeUrl[ProfileTableViewController.shared.myIndex])!)
        // load the webview
        webView.navigationDelegate = self
        webView.load(request)
    }
    
    // make spinner animating
    func webView(_ webView: WKWebView,
                didStartProvisionalNavigation navigation: WKNavigation!) {
        spinner.startAnimating()
   }
    
    // stop spinner animating
   func webView(_ webView: WKWebView, didFinish: WKNavigation!) {
       spinner.stopAnimating()
   }
    
    // stop spinner animating after webview loaded
   func webView(_ webView: WKWebView,
                didFailProvisionalNavigation navigation: WKNavigation!,
                withError error: Error) {
       spinner.stopAnimating()
   }
}
