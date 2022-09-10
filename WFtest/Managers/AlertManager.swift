import UIKit
import SystemConfiguration

// MARK: - Internet connection status checker

class Reachability {
    public func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        if flags.isEmpty {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}

// MARK: - Add global alert

extension UIViewController {
    
    func getAlert(title: String, message: String, action: @escaping()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default) { (_) in
            action()
        }
        alert.addAction(alertOk)
        present(alert, animated: true, completion: nil)
    }
    
    func checkConnection(action:Void) {
        !Reachability().isConnectedToNetwork()
            ? getAlert(title: "No Internet Connection",
                       message: "Please check your internet connection",
                       action: {[weak self] in
                        action
                       })
            : nil
    }
    
}




