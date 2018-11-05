//
//  NovaRandom.swift
//  NovaCore
//

import Foundation

extension Array {
    
    public func random() -> Element? {
        if self.count > 0 {
            let randIdx = arc4random_uniform(UInt32(count)) % UInt32(count)
            return self[Int(randIdx)]
        }
        return nil
    }
    
}
