//
//  ContentView.swift
//  ShazamAPI
//
//  Created by Babypowder on 13/3/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @State private var isRecording = false
    @ObservedObject var viewModel = AudioViewModel()
    @State var covert = ""
    
    var body: some View {
        ZStack {
            Image("default")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 7)
                .brightness(-0.4)
            
            
            if let track = viewModel.result {
                if let coverArtUrl = URL(string: track.images.coverart) {
                    AsyncImage(url: coverArtUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            
            VStack {
                if let track = viewModel.result {
                    
                    if let coverArtUrl = URL(string: track.images.coverart) {
                        
                        AsyncImage(url: coverArtUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(25)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                    }
                    
                    Text("Title: \(track.title)")
                    Text("Subtitle: \(track.subtitle)")
                    
                    if let url = URL(string: track.url) {
                        Link(destination: url) {
                            Image(systemName: "link.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue)
                        }
                    } else {
                        Text("URL not found")
                    }
                }
                else {
                    Image("default")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .cornerRadius(25)
                }
                Text(viewModel.message)
                    .background()
                
                Button(isRecording ? "Stop Recording" : "Start Recording") {
                    isRecording.toggle()
                    if isRecording {
                        viewModel.startRecordingTapped()
                    } else {
                        viewModel.stopRecordingTapped()
                    }
                }
                .foregroundColor(isRecording ? .black : .white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(isRecording ? Color.pinkred : Color.black))
                
                
                
            }
        }
    }
}



#Preview {
    ContentView()
}
