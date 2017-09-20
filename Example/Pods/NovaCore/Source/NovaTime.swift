//
//  NovaTime.swift
//  NovaCore
//

import Foundation

extension Double {

    public var timeMSF: String {
        var elapsed = self
        let mins = Int(floor(elapsed / 60.0))
        elapsed -= Double(mins * 60)
        let secs = Int(floor(elapsed))
        elapsed -= Double(secs)
        let fraction = Int(elapsed * 10)
        return String(format: "%02d:%02d.%01d", mins, secs, fraction)
    }

    public var timeMS: String {
        var elapsed = self
        let mins = Int(floor(elapsed / 60.0))
        elapsed -= Double(mins * 60)
        let secs = Int(floor(elapsed))
        return String(format: "%02d:%02d", mins, secs)
    }

    public var timeHMS: String {
        var elapsed = self
        let hours = Int(floor(elapsed / 3600))
        elapsed -= Double(hours * 3600);
        let mins = Int(floor(elapsed / 60.0))
        elapsed -= Double(mins * 60)
        let secs = Int(floor(elapsed))
        return String(format: "%02d:%02d:%02d", hours, mins, secs)
    }

    public var timeHMSTrimmed: String {
        var elapsed = self
        let hours = Int(floor(elapsed / 3600))
        if hours == 0 {
            return self.timeMS
        }
        elapsed -= Double(hours * 3600);
        let mins = Int(floor(elapsed / 60.0))
        elapsed -= Double(mins * 60)
        let secs = Int(floor(elapsed))
        return String(format: "%02d:%02d:%02d", hours, mins, secs)
    }

    public var timeHM: String {
        var elapsed = self
        let hours = Int(floor(elapsed / 3600))
        elapsed -= Double(hours * 3600);
        let mins = Int(floor(elapsed / 60.0))
        return String(format: "%02d:%02d", hours, mins)
    }
    
}
