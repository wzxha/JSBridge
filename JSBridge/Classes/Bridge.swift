import Foundation
import WebKit

public protocol Bridgeable {
    static var name: String { get }
    
    static var methods: [String] { get }
    
    var delegate: WKScriptMessageHandler? { set get }
}

public extension Bridgeable {
    
    fileprivate var userContentController: WKUserContentController {
        
        let userContentController = WKUserContentController()
        
        let source = "window.\(Self.name)=window.\(Self.name)||{};for(var _arr=\(Self.methods),_loop=function(){var a=_arr[_i];window.\(Self.name)[a]=function(b){window.webkit.messageHandlers[a].postMessage(b),console.log('[bridge] native expose method called: '+a)}},_i=0;_i<_arr.length;_i++)_loop();"
        
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        userContentController.addUserScript(userScript)
        
        if let delegate = delegate {
            Self.methods.forEach { userContentController.add(delegate, name: $0) }
        }
        
        return userContentController
    }
}

public extension WKWebViewConfiguration {
    var bridge: Bridgeable? {
        set {
            guard let userContentController = newValue?.userContentController else {
                return
            }
            
            self.userContentController = userContentController
        }
        
        get { return nil }
    }
}
