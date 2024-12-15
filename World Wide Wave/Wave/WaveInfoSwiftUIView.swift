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

struct MediaPicker: View {
    @Binding var selectedImage: UIImage?
    @Binding var selectedVideoURL: URL?
    
    var body: some View {
        HStack{
            Spacer()
            Button( action: {
                
            }) {
                Text("Photo")
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.cyan)
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
                
            }
            
            Spacer()
            
            Button( action: {
                
            }) {
                Text("Video")
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.white)
                    .background(Color.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
               
            }
            
            Spacer()
            
        }
    }
}

struct WaveInfoSwiftUIView: View {
    
    
    @State private var waveSize: String = ""
    @State private var selectedSize: String = ""
    @State private var isSizeSelect: Bool = false
    @State private var isPickerVisble: Bool = false
    
    var coordinate: CLLocationCoordinate2D
    var timestamp: Date
    @State var selectedImage: UIImage?
    @State var selectedVideoURL: URL?
    
    var body: some View {
        NavigationView {
           
                GeometryReader { geometry in
                    VStack{
                        Button(action: {
                            isPickerVisble.toggle()
                        }) {
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .grayscale(0.7)
                                    .frame(width: geometry.size.width * 1.0, height: geometry.size.height * 0.4)
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.2), radius: 9, x: 3, y: 6)
                            } else if let videoURL = selectedVideoURL {
                                VideoPlayer(player: AVPlayer(url: videoURL))
                                    .frame(width: geometry.size.width * 1.0, height: geometry.size.height * 0.4)
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.2), radius: 9, x: 3, y: 6)
                            } else {
                                Image("Logo")
                                    .resizable()
                                    .scaledToFill()
                                    .grayscale(0.7)
                                    .frame(width: geometry.size.width * 1.0, height: geometry.size.height * 0.4)
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.2), radius: 9, x: 3, y: 6)
                                
                            }
                                
                        }.sheet(isPresented: $isPickerVisble) {
                            MediaPicker(selectedImage: $selectedImage, selectedVideoURL: $selectedVideoURL)
                                .presentationDetents([.fraction(0.25), .medium, .large])
                                .presentationDragIndicator(.visible)
                            
                            
                        }
                        
                        Form {
                            Section("SIZE") {
                                ZStack{
                                    
                                    TextField("shorebreak", text: $waveSize)
                                        .disabled(true)
                                }
                            }
                            
                            .headerProminence(.increased)
                            .onTapGesture {
                                withAnimation {
                                    isSizeSelect.toggle()
                                }
                            }
                            
                            if isSizeSelect {
                                Picker("", selection: $selectedSize){
                                    Text("Shorebreak").tag("Shorebreak")
                                    Text("minimal")
                                        .tag("minimal")
                                }
                                .pickerStyle(.menu)
                                .labelsHidden()
                                .frame(width: .infinity)
                                .onChange( of: selectedSize) {
                                   
                                    waveSize = selectedSize
                                    withAnimation{
                                        isSizeSelect = false
                                    }
                                }
                                
                                
                            }
                        }.cornerRadius(20)
                            .shadow(color: .black.opacity(0.2), radius: 9, x: 3, y: 6)
                       
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
                .frame(maxHeight: .infinity)
                .ignoresSafeArea()
                
             
          
    
        }
        
    }
    
}

#Preview {
    
    let mockCoordinate = CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917)
    let mockTimestamp = Date()

    WaveInfoSwiftUIView(coordinate: mockCoordinate, timestamp: mockTimestamp)
}
