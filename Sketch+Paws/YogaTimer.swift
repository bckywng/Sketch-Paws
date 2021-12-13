//
//  YogaTimer.swift
//  Sketch+Paws
//
//  Created by becky wong on 12/13/21.
//

import Foundation

class YogaTimer{
    
    // Timer states
    var timerActive = false
    var timerPaused = false
    var timerEnded = false
    var timerDuration = 30
    var yogaTimer = Timer()
    
    // Start the Timer
    func startTimer(){
        timerActive = true
        yogaTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {Timer in
            self.timerDuration -= 1
            if self.timerDuration == 0{
                self.stopTimer()
            }
        })
    }
      
    // Pause the Timer
    func pauseTimer(){
        timerActive = false
        timerPaused = true
        yogaTimer.invalidate()
    }
    // End the Timer
    func stopTimer(){
        timerEnded = true
        timerActive = false
        yogaTimer.invalidate()
        timerDuration = 30
        
    }
    // Play a Sound
    func playSound(){
        
    }
    // Countdown

}




