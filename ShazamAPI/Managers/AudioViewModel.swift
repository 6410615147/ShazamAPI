//
//  AudioViewModel.swift
//  ShazamAPI
//
//  Created by Babypowder on 13/3/2567 BE.
//

import Foundation

class AudioViewModel: ObservableObject {
    private var audioManager = AudioManager()
    @Published var message: String = ""
    @Published var result: Track?
    @Published var sectionUrl: String?
    
    func startRecordingTapped() {
        audioManager.requestMicrophoneAccess()
        audioManager.startRecording()
        message = ""
    }
    
    func stopRecordingTapped() {
        audioManager.stopRecording()
        print("start to stop record")
        audioManager.uploadRecording { [weak self] jsonData in
            self?.parseShazamResponse(jsonData)
        }
    }
    

    private func parseShazamResponse(_ jsonData: Data) {
        let decoder = JSONDecoder()

        do {
            let response = try decoder.decode(ResponseManager.self, from: jsonData)
            DispatchQueue.main.async {
                
                if let track = response.track {
                    self.result = track
                    self.message = "Track Found!"
                } else {
                    self.message = "No track data found."
                }
                
            }
        } catch {
            DispatchQueue.main.async {
                print("Error parsing JSON: \(error)")
            }
        }
    }

}
