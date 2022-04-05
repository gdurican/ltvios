//
//  WebViewController.swift
//  ltvios
//
//  Created by gabriel durican on 4/5/22.
//

import Foundation
import UIKit
import WebKit

//a simple controller displaying a full screen webview
class WebViewController: UIViewController, Storyboarded {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        guard let request = createUrlRequest(urlString: urlString) else {
            return
        }
        
        showLoading(true)
        webView.load(request)
    }
    
    func createUrlRequest(urlString: String?) -> URLRequest? {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            return nil
        }

        let request = URLRequest(url: url)
        
        return request
    }
    
    func showLoading(_ show: Bool) {
        show == true ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = show == false
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showLoading(false)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showLoading(false)
        AlertController().present(on: self, title: "Error", message: "Something went wrong. Please retry", onCancel: nil)
    }
}
