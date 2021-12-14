//
//  YogaTimer.swift
//  Sketch+Paws
//
//  Created by becky wong on 12/13/21.
//

import Foundation
import AVFoundation

class YogaTimer: ObservableObject {
    
    // Timer states
    @Published var timerActive = false
    @Published var timerPaused = false
    @Published var timerEnded = false
    @Published var timerDuration = 30
    var yogaTimer = Timer()
    var audioPlayer: AVAudioPlayer?
    
    // Start the Timer
    func startTimer(){
        timerActive = true
        timerPaused = false
        timerEnded = false
        yogaTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {Timer in
            self.timerDuration -= 1
            if self.timerDuration == 0 {
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
        playSound(sound: "chime", type: "wav")
        timerEnded = true
        timerActive = false
        yogaTimer.invalidate()
        timerDuration = 30
        
    }
    // Play a Sound
    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("ERROR")
            }
        }
    }
    // Timer styles
    func setTitleText() -> String {
        if timerEnded {
            return "You did it"
        } else {
            return "Hold that pose"
        }
    }
    
    func setDescriptionText() -> String {
        if timerEnded {
            return "Purrfect!"
        } else {
            return "Try staying in this pose for 30 seconds. If you need to come out sonner, that's ok."
        }
         
    }

}




