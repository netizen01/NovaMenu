//
//  NovaTime.swift
//  NovaCore
//

import Foundation

extension Double {

    public var timeMSF: String {
        if self == Double.infinity { return "∞" }
        var elapsed = self
        let mins = Int(floor(elapsed / 60.0))
        elapsed -= Double(mins * 60)
        let secs = Int(floor(elapsed))
        elapsed -= Double(secs)
        let fraction = Int(elapsed * 10)
        return String(format: "%02d:%02d.%01d", mins, secs, fraction)
    }
    
    public var timeMSFTrimmed: String {
        if self == Double.infinity { return "∞" }
        var elapsed = self
        let mins = Int(floor(elapsed / 60.0))
        if mins == 0 {
            return self.timeSF
        }
        elapsed -= Double(mins * 60)
        let secs = Int(floor(elapsed))
        elapsed -= Double(secs)
        let fraction = Int(elapsed * 10)
        return String(format: "%02d:%02d.%01d", mins, secs, fraction)
    }
    
    public var timeMSM: String {
        if self == Double.infinity { return "∞" }
        var elapsed = self
        let mins = Int(floor(elapsed / 60.0))
        elapsed -= Double(mins * 60)
        let secs = Int(floor(elapsed))
        elapsed -= Double(secs)
        let fraction = Int(ceil(elapsed * 1000))
        return String(format: "%02d:%02d.%03d", mins, secs, fraction)
    }
    
    public var timeSM: String {
        if self == Double.infinity { return "∞" }
        var elapsed = self
        let secs = Int(floor(elapsed))
        elapsed -= Double(secs)
        let fraction = Int(ceil(elapsed * 1000))
        return String(format: "%02d.%03d", secs, fraction)
    }
    
    public var timeMSMTrimmed: String {
        if self == Double.infinity { return "∞" }
        var elapsed = self
        let mins = Int(floor(elapsed / 60.0))
        if mins == 0 {
            return self.timeSM
        }
        elapsed -= Double(mins * 60)
        let secs = Int(floor(elapsed))
        elapsed -= Double(secs)
        let fraction = Int(ceil(elapsed * 1000))
        return String(format: "%02d:%02d.%03d", mins, secs, fraction)
    }
    
    public var timeSF: String {
        if self == Double.infinity { return "∞" }
        var elapsed = self
        let secs = Int(floor(elapsed))
        elapsed -= Double(secs)
        let fraction = Int(elapsed * 10)
        return String(format: "%02d.%01d", secs, fraction)
    }
    
    public var timeMS: String {
        if self == Double.infinity { return "∞" }
        var elapsed = self
        let mins = Int(floor(elapsed / 60.0))
        elapsed -= Double(mins * 60)
        let secs = Int(floor(elapsed))
        return String(format: "%02d:%02d", mins, secs)
    }
    
    public var timeHMS: String {
        if self == Double.infinity { return "∞" }
        var elapsed = self
        let hours = Int(floor(elapsed / 3600))
        elapsed -= Double(hours * 3600);
        let mins = Int(floor(elapsed / 60.0))
        elapsed -= Double(mins * 60)
        let secs = Int(floor(elapsed))
        return String(format: "%02d:%02d:%02d", hours, mins, secs)
    }
    
    public var timeHMSTrimmed: String {
        if self == Double.infinity { return "∞" }
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
        if self == Double.infinity { return "∞" }
        var elapsed = self
        let hours = Int(floor(elapsed / 3600))
        elapsed -= Double(hours * 3600);
        let mins = Int(floor(elapsed / 60.0))
        return String(format: "%02d:%02d", hours, mins)
    }
    
}
