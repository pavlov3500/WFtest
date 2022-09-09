import UIKit
import SystemConfiguration

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

extension UIViewController {
    func getAlert(title: String, message: String, action: @escaping()->()) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default) { (_) in
            action()
        }
        alert.addAction(alertOk)
        return alert
    }
    
    func checkConnection() {
        !Reachability().isConnectedToNetwork()
            ? present(getAlert(title: "No Internet Connection",
                               message: "Please check your internet connection",
                               action: {
                                self.checkConnection()
                               }),
                      animated: true,
                      completion: nil)
            : nil
    }
}




