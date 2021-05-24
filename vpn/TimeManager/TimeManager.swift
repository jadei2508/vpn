//
//  TimeManager.swift
//  vpn
//
//  Created by Roman Alikevich on 24.05.2021.
//

import UIKit

class TimeManager {
    private var timeBuffer: Timer?
    private var counter: Int = 0
    var timeTransmiss: ((String) -> ())?
    func startTimer() {
        timeBuffer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    func pause() {
        timeBuffer?.invalidate()
    }
    
    func continues() {
        timeBuffer?.fire()
    }
    
    @objc func updateTimer() {
        counter += 1
        if let action = timeTransmiss {
            action(getCurrentTime())
        }
     }
    
    func getCurrentTime() -> String {
        return timeString(time: TimeInterval(counter))
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func timerClear() {
        counter = 0
    }
}
