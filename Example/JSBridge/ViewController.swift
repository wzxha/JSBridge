//
//  ViewController.swift
//  JSBridge
//
//  Created by Wzxhaha on 09/12/2017.
//  Copyright (c) 2017 Wzxhaha. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore
import JSBridge

class Bridge: Bridgeable {
    var delegate: WKScriptMessageHandler?

    static var name: String {
        return "Test"
    }
    
    static var methods: [String] {
        return [
            "method1",
            "method2",
            "method3"
        ]
    }
    
    init(_ delegate: WKScriptMessageHandler?) {
        self.delegate = delegate
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = WKWebViewConfiguration()
        
        config.bridge = Bridge(self)
        
        let webView = WKWebView(frame: view.bounds, configuration: config)
        
        view.addSubview(webView)
        
        guard let htmlUrl = Bundle.main.url(forResource: "index", withExtension: ".html") else {
            return
        }
        
        webView.load(URLRequest(url: htmlUrl))
    }
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let methodName = message.name
        let body = message.body
        
        print("name: \(methodName), body: \(body)")
        
        let alertController = UIAlertController(title: "Tip", message: "You are clicked \(methodName)", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Sure", style: .cancel))
        
        self.present(alertController, animated: true)
    }
}

