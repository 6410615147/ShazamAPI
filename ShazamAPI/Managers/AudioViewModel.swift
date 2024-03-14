//
//  AudioViewModel.swift
//  ShazamAPI
//
//  Created by Babypowder on 13/3/2567 BE.
//

import Foundation

class AudioViewModel: ObservableObject {
    private var audioManager = AudioManager()
    @Published var message: String = "Start Record"
    @Published var result: Track?
    @Published var sectionUrl: String?
    
    func startRecordingTapped() {
        audioManager.requestMicrophoneAccess()
        audioManager.startRecording()
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
                    
                    print("Title: \(self.result?.title ?? "Title not found")")
                    print("Subtitle: \(self.result?.subtitle ?? "Subtitle not found")")
                    print("Cover Art: \(self.result?.images.coverart ?? "Cover art not found")")
                    print("URL: \(self.result?.url ?? "URL not found")")
                    
                    self.message = "Track Found!"
                } else {
                    self.message = "No track data found"
                }
                
            }
        } catch {
            DispatchQueue.main.async {
                print("Error parsing JSON: \(error)")
            }
        }
    }

}
