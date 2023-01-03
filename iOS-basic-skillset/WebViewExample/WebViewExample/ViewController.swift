//
//  ViewController.swift
//  WebViewExample
//
//  Created by Monil Gandhi on 14/06/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import SVProgressHUD
import UIKit
import WebKit

class ViewController: UIViewController {
    var webView: WKWebView!
    var progressView: UIProgressView!
    //  var reachability: Reachability? = Reachability.networkReachabilityForInternetConnection()
    var reachability = Reachability(hostName: "www.apple.com")

    deinit {
        NotificationCenter.default.removeObserver(self)
        reachability?.stopNotifier()
    }

    var indicatior: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "Loading")
        navigationController?.title = "WebView Example"
//    navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Star Jedi" , size: 20)!]
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityDidChange(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotificationName), object: nil)

        _ = reachability?.startNotifier()
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        indicatior = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicatior.frame = CGRect(x: view.frame.size.width / 2, y: view.frame.size.height / 2, width: 50, height: 50)
        view.addSubview(indicatior)
        indicatior.startAnimating()
        initProgress()
        indicatior.hidesWhenStopped = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkReachability()
    }

    @objc func reachabilityDidChange(_: Notification) {
        checkReachability()
    }

    func checkReachability() {
        guard let r = reachability else { return }
        if r.isReachable {
            let url = URL(string: "https://www.hackingwithswift.com/example-code/wkwebview/how-to-load-http-content-in-wkwebview-and-uiwebview")!
            webView.load(URLRequest(url: url))
        }
    }

    func initProgress() {
        let navBounds = navigationController?.navigationBar.bounds

        progressView = UIProgressView(frame: CGRect(x: 0, y: (navBounds?.height)! - 2, width: (navBounds?.width)!, height: 2))
        navigationController?.navigationBar.addSubview(progressView)
        progressView.progressViewStyle = .bar
        progressView.progress = 0.9
    }
}

extension ViewController: WKUIDelegate {
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func observeValue(forKeyPath keyPath: String?, of _: Any?, change _: [NSKeyValueChangeKey: Any]?, context _: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress == 1.0 {
                indicatior.stopAnimating()
                SVProgressHUD.dismiss()
                progressView.isHidden = true
            } else {
                progressView.isHidden = false
            }
        }
    }
}
