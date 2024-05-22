//
//  ViewController.swift
//  TextToSpeech
//
//  Created by Sanzhar Koshkarbayev on 08.11.2022.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var speechTextTextField: UITextField!
    
    let synth = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSynthesizer()
    }
    
    @IBAction func speechTapped(_ sender: Any) {
        guard let textToSpeech = speechTextTextField.text else { return }
        textToSpeech.speak(synth: synth)
    }
    

}

extension ViewController: AVSpeechSynthesizerDelegate {
    
    private func configureSynthesizer() {
        synth.delegate = self
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, options: [.defaultToSpeaker, .allowBluetooth, .allowBluetoothA2DP])
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch let error as NSError {
            print("Error: Could not setActive to true: \(error), \(error.userInfo)")
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("STARTED")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("STOPPED")
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
    }
    
}




extension String {
    
    func speak(synth: AVSpeechSynthesizer) {
        let say = self
        let utterance = AVSpeechUtterance(string: say)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.43
        utterance.pitchMultiplier = 1.26
        utterance.volume = 1
        synth.speak(utterance)
    }
    
}
