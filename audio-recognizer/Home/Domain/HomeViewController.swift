//
//  HomeViewController.swift
//  audio-recognizer
//
//  Created by Leandro Bartsch Thá on 04/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import UIKit
import Speech

class HomeViewController: UIViewController {
    @IBOutlet weak var lblListening: UILabel!
    @IBOutlet weak var lblWord: UILabel!
    @IBOutlet weak var btnListening: UIButton!
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblListening.text = "Waiting"
        lblListening.textColor = .red
    }
    
    @IBAction func onClickButton(_ sender: Any) {
        lblListening.text = lblListening.text == "Listening" ? "Waiting" : "Listening"
        lblListening.textColor = lblListening.text == "Listening" ? .green : .red
        
        if lblListening.text == "Listening" {
            recordAndRecognize()
            print("start")
        } else {
            audioEngine.stop()
            print("stop")
        }
    }
    
    func recordAndRecognize() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat, block: { buffer, _ in
            self.request.append(buffer)
        })
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch let error {
            print(error.localizedDescription)
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                self.lblWord.text = result.bestTranscription.formattedString
                print(result)
            } else if let error = error {
                print(error.localizedDescription)
            }
        })
    }
}

extension HomeViewController: SFSpeechRecognizerDelegate {
    
}
