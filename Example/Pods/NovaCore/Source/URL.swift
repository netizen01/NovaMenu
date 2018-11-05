//
//  URL.swift
//  NovaCore
//

import Foundation

extension URL {
    
    public func queryStringComponents() -> [String: String] {
        var dict = [String: String]()
        if let query = self.query {
            for pair in query.components(separatedBy: "&") {
                let components = pair.components(separatedBy: "=")
                if components.count == 1 {
                    //                    let key = components[0].stringByRemovingPercentEncoding!
                    //                    dict[key] = NSNull.null
                } else if components.count == 2 {
                    let key = components[0].removingPercentEncoding!
                    let value = components[1].removingPercentEncoding!
                    dict[key] = value
                }
            }
        }
        return dict
    }
}

