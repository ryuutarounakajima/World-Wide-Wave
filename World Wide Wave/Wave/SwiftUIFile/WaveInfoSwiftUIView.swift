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
    
    //Wave size select
    @State private var waveSize: String = ""
    @State private var selectedSize: String = ""
    @State private var isSizeSelect: Bool = false
    @State private var waveSizes: [(key: String, value: String)] = [ ("" , ""), ("Shorebreak" , "Shorebreak"), ("Small" , "Small"), ("Chest-high" , "Chest-high"), ("Head-high", "Head-high"), ("Overhead", "Overhead"), ("Double", "Double"), ("Triple over", "Triple over")
    ]
    
    //Wave condition select
    
    //Photo picker visible
    @State private var isPickerVisable: Bool = false
    
    var coordinate: CLLocationCoordinate2D
    var timestamp: Date
    @State var selectedImage: UIImage?
    @State var selectedVideoURL: URL?
    
    var body: some View {
        NavigationView {
           
                GeometryReader { geometry in
                    VStack{
                        
                        Button(action: {
                            isPickerVisable.toggle()
                        }) {
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: geometry.size.width * 1.0, height: geometry.size.height * 0.4)
                                    .modifier(MediaFrameModifier())
                                    
                            } else if let videoURL = selectedVideoURL {
                                VideoPlayer(player: AVPlayer(url: videoURL))
                                    .modifier(MediaFrameModifier())
                            } else {
                                Image("Logo")
                                    .resizable()
                                    .frame(width: geometry.size.width * 1.0, height: geometry.size.height * 0.4)
                                    .modifier(MediaFrameModifier())
                                    
                                
                            }
                            
                        }.sheet(isPresented: $isPickerVisable) {
                            MediaPicker(selectedImage: $selectedImage, selectedVideoURL: $selectedVideoURL)
                                .presentationDetents([.fraction(0.25), .medium, .large])
                                .presentationDragIndicator(.visible)
                            
                            
                        }
                       
                                Form {
                                    
                                    Section(header: Button(action: {
                                        isSizeSelect.toggle()
                                            }){
                                             Text("Size")
                                                    .headerProminence(.increased)
                                                    .modifier(SectionBuutonModifier())
                                            }){
                                        if isSizeSelect {
                                            Picker("", selection: $selectedSize){
                                                ForEach(waveSizes, id: \.key) { size in
                                                    Text(size.value).tag(size.key)
                                                }
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
                            .padding([.leading, .trailing, .bottom])
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
