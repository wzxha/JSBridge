# JSBridge

[![CI Status](http://img.shields.io/travis/Wzxhaha/JSBridge.svg?style=flat)](https://travis-ci.org/Wzxhaha/JSBridge)
[![Version](https://img.shields.io/cocoapods/v/JSBridge.svg?style=flat)](http://cocoapods.org/pods/JSBridge)
[![License](https://img.shields.io/cocoapods/l/JSBridge.svg?style=flat)](http://cocoapods.org/pods/JSBridge)
[![Platform](https://img.shields.io/cocoapods/p/JSBridge.svg?style=flat)](http://cocoapods.org/pods/JSBridge)

easier to call Native with JavaScript.

# Use

1. Create a class that implementation `Bridgeable`
```
import JSBridge

class Bridge: Bridgeable {
    var delegate: WKScriptMessageHandler?

    static var name: String {
        return "Test"
    }
    
    static var methods: [String] {
        return [
            "method1",
            ...
        ]
    }
    
    init(_ delegate: WKScriptMessageHandler?) {
        self.delegate = delegate
    }
}
```

2. Set configuration's bridge

```
let config = WKWebViewConfiguration()
config.bridge = Bridge(self)
let webView = WKWebView(frame: view.bounds, configuration: config)
```

3. Receive message in `-userContentController:didReceive:`
```
extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let methodName = message.name
        let body = message.body
        print("name: \(methodName), body: \(body)")
    }
}
```


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

JSBridge is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JSBridge'
```

## Todo 📒

- support on UIWebView
- simpler and more elegant
- more..

## License

JSBridge is available under the MIT license. See the LICENSE file for more info.
