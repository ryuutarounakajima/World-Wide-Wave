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
                    .foregroundStyle(.brown)
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .bold()
                
                
            }
            
            Spacer()
            
            Button( action: {
                
            }) {
                Text("Video")
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.white)
                    .background(Color.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .bold()
                
               
            }
            
            Spacer()
            
        }
    }
}

struct WaveInfoSwiftUIView: View {
    
    //Wave size select
    @State private var waveSize: String = ""
    @State private var selectedSize: String = ""
    @State private var isSizeSelect: Bool = false
    //Wave condition select
    
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
                                    
                                    Section(header: Button(action: {
                                        isSizeSelect.toggle()
                                            }){
                                             Text("Size")
                                                    .font(.headline)
                                                    .foregroundStyle(.white)
                                                    .fontWeight(.bold)
                                                    .shadow(radius: 2, x: 4, y: 6)
                                                    .padding([.leading,.trailing])
                                                    .background(.secondary)
                                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                                    .shadow(radius: 2, x: 4, y: 6)
                                            }){
                                        if isSizeSelect {
                                            Picker("", selection: $selectedSize){
                                                Text("")
                                                    .tag("")
                                                Text("Shorebreak")
                                                    .tag("Shorebreak")
                                                Text("Small")
                                                    .tag("Small")
                                                Text("Chest-high")
                                                    .tag("Chest-high")
                                                Text("Head-high")
                                                    .tag("Head-high")
                                                Text("Overhead")
                                                    .tag("Overhead")
                                                Text("Double")
                                                    .tag("Double")
                                                Text("Triple over")
                                                    .tag("Triple over")
                                            }
                                            .pickerStyle(.wheel)
                                            .labelsHidden()
                                            .frame(width: .infinity)
                                            .onChange( of: selectedSize) {
                                                waveSize = selectedSize
                                                withAnimation{
                                                    isSizeSelect = false
                                                }
                                            }
                                        }
                                        //Logged wave size
                                        Text(waveSize)
                                    }
                                    

                                }
                                .cornerRadius(20)
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
