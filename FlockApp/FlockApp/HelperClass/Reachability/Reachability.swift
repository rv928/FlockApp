//
//  Reachability.swift
//  MessagerApp
//
//  Created by Ravi vora on 15/08/19.
//  Copyright © 2019 Ravi vora. All rights reserved.
//

import Foundation
import Network

public class Reachability {
    
    let monitor = NWPathMonitor()

    func checkInternet(completion:@escaping ( (_ isReachable:Bool)  -> Void)) {
       
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { path in
            if path.usesInterfaceType(.wifi) {
            }
            else if path.usesInterfaceType(.cellular) {
            }
            if path.status == .satisfied {
                completion(true)
            }
            else {
                completion(false)
            }
        }
    }
}
