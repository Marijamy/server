//
//  ViewController.swift
//  Server_AksenovaMV
//
//  Created by Klepa on 31.10.2021.
//

import UIKit
import WebKit
import Alamofire


class ViewController: UIViewController {
  
    
    @IBOutlet weak var webView: WKWebView! {
        didSet{ webView.navigationDelegate = self
        }
    }
    
    let fromLoginToFriendsSegue = "FromLoginToFriends"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorize()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func authorize() {
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "oauth.vk.com"
                urlComponents.path = "/authorize"
                urlComponents.queryItems = [
                    URLQueryItem(name: "client_id", value: "7961448"),
                    URLQueryItem(name: "display", value: "mobile"),
                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                    URLQueryItem(name: "scope", value: "262150"),
                    URLQueryItem(name: "response_type", value: "code"),
                    URLQueryItem(name: "v", value: "5.81")
                ]

                let request = URLRequest(url: urlComponents.url!)

                webView.load(request)
    }
}


extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

    guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
                
        
        print(url)

        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }

        let token = params["access_token"]
                
        print(token)

        performSegue(withIdentifier: "FromLoginToFriends", sender: nil)

        decisionHandler(.cancel)
    }

}
