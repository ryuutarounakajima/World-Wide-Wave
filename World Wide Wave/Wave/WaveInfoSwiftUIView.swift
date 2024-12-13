//
//  WaveInfoSwiftUI.swift
//  World Wide Wave
//
//  Created by Ryuutarou Nakajima on 2024/12/02.
//

import SwiftUI
import MapKit
import CoreLocation
import AVKit

struct WaveInfoSwiftUIView: View {
    
    @State private var waveSize: String = ""
    @State private var isPickderVisible: Bool = false
    var coordinate: CLLocationCoordinate2D
    var timestamp: Date
    var image: UIImage?
    var videoURL: URL?
    
    var body: some View {
    
        /*ScrollView{
                HStack {
                      
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .padding()
                        
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .padding()
                        
                    }
                    
                    if let videoURL = videoURL {
                        
                        VideoPlayer(player: AVPlayer(url: videoURL))
                            .frame(height: 200)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .padding()

                    } else {
                        Image(systemName: "video")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .padding()
                    }
                    
                    
                        
                    }
                }
            
        
            ZStack {
                
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.cyan.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    
                    TextField("Tap to select", text: $waveSize)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                        .onTapGesture {
                            
                            withAnimation {
                                isPickderVisible.toggle()
                            }
                            
                        }
                    
                    if isPickderVisible {
                        Picker("Wave size", selection: $waveSize) {
                            Text("Shorebreak").tag("Shorebreak")
                            Text("Minimal").tag("Minimal")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                        .onChange(of: waveSize) {
                            
                            withAnimation{
                                isPickderVisible = false
                            }
                        }
                    }
                    
                }
                
            }
            .cornerRadius(10)
            .frame(height: 40)
            .frame(maxWidth: .infinity)
        */
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    VStack{
                        Button(action: {
                            isPickderVisible.toggle()
                        }) {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(20)
                .padding()
                //locations
                VStack(alignment: .trailing) {
                    
                    Text("latitude: \(coordinate.latitude)")
                    
                    Text("longitude:\(coordinate.longitude)")
                    
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                //The time
                Text("\(timestamp)")
            }
    
        }
        
    }
    
}

#Preview {
    
    let mockCoordinate = CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917)
    let mockTimestamp = Date()

    WaveInfoSwiftUIView(coordinate: mockCoordinate, timestamp: mockTimestamp)
}
