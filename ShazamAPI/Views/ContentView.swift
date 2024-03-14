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
                Text(viewModel.message)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                
                if let track = viewModel.result {
                    
                    if let coverArtUrl = URL(string: track.images.coverart) {
                        
                        AsyncImage(url: coverArtUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 300, height: 300)
                        .cornerRadius(25)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Title: ").bold() + Text("\(track.title)")
                        Text("Artist: ").bold() + Text(track.subtitle)
                    
                        HStack{
                            if let url = URL(string: track.url) {
                                Link(destination: url) {
                                    Image(systemName: "link.circle.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.black.opacity(0.7))
                                }
                            }
                        }
                        .frame(width: 250, alignment: .center)
                    }
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(7)
                    .frame(width: 300)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    
                }
                else {
                    Image("default")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .cornerRadius(25)
                }
                
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
