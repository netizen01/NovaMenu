//
//  NovaScroller.swift
//  NovaCore
//

import UIKit

public class NovaScroller {
    
    public typealias NovaScrollerCallback = (Bool) -> Void
    
    public var pause: Double = 0
    public var direction: Bool = true
    public weak var scrollView: UIScrollView?
    public var pointsPerSecond: CGFloat = 100
    public var callback: NovaScrollerCallback?
    
    class Linker {
        weak var scroller: NovaScroller?
        
        init(scroller: NovaScroller) {
            self.scroller = scroller
        }
        
        @objc fileprivate func displayLinkTick() {
            scroller?.displayLinkTick()
        }
    }
    
    private var displayLink: CADisplayLink?
    private var lastTick: Double = 0
    private var pauseRemaining: Double = 0
    
    public init() {
        
    }
    
    deinit {
        end()
    }
    
    public func begin() {
        lastTick = 0
        displayLink = CADisplayLink(target: Linker(scroller: self), selector: #selector(Linker.displayLinkTick))
        if #available(iOS 10.0, *) {
            displayLink?.preferredFramesPerSecond = 60
        } else {
            displayLink?.frameInterval = 1
        }
        displayLink?.add(to: RunLoop.current, forMode: .common)
    }
    
    public func end() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    private func displayLinkTick() {
        guard let displayLink = displayLink else { return }
        guard let scrollView = scrollView else { return }
        if lastTick == 0 {
            lastTick = displayLink.timestamp
            return
        }
        let current = displayLink.timestamp
        let delta = current - lastTick
        if pauseRemaining > 0 {
            pauseRemaining = max(0, pauseRemaining - delta)
        } else if !scrollView.isTracking {
            let deltaY = pointsPerSecond * CGFloat(delta)
            var offset = scrollView.contentOffset
            if direction {
                offset.y += deltaY
            } else {
                offset.y -= deltaY
            }
            scrollView.contentOffset = offset
            
            if scrollView.contentSize.height - offset.y <= scrollView.frame.height && direction {
                direction = false
                pauseRemaining = pause
                callback?(direction)
            } else if offset.y <= 0 && !direction {
                direction = true
                pauseRemaining = pause
                callback?(direction)
            }
        }
        lastTick = current
    }
    
}
