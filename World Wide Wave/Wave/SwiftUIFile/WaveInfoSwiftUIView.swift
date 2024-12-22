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
    @State private var waveSizes: [(key: String, value: String)] = [ ("" , ""), ("Small" , "Small"), ("Chest-high" , "Chest-high"), ("Head-high", "Head-high"), ("Overhead", "Overhead"), ("Double", "Double"), ("Triple over", "Triple over")
    ]
    
    //Wave condition select
    @State private var waveCondition: String = ""
    @State private var selectedCondition: String = ""
    @State private var isConditionSelect: Bool = false
    @State private var waveConditions: [(key: String, value: String)] = [("", ""), ("Shorebreak", "Shorebreak"), ("Choppy", "Choppy"), ("Mushy", "Mushy"), ("Windy", "windy"), ("Clean", "Clean"), ("Glass", "Glass"), ("Rippable", "Rippable"), ("Barrels", "Barrels"), ("Peaky", "Peaky"), ("Gnarly", "Gnarly"), ("Close out", "Close out") ]
    
    //Swell
    @State private var swell: String = ""
    @State private var selectedSwell: String = ""
    @State private var isSwellSelected: Bool = false
    @State private var swells: [(key: String, value: String)] = [("", ""), ("N", "N"), ("NNE", "NNE"), ("NE", "NE"), ("ENE", "ENE"), ("E", "E"), ("ESE", "ESE"), ("SE", "SE"), ("SSE", "SSE"), ("S", "S"), ("SSW", "SSW"), ("SW", "SW"), ("WSW", "WSW"), ("W", "W"), ("WNW", "WNW"), ("NW", "NW"), ("NNW", "NNW")]
    
    //Winds
    @State private var wind: String = ""
    @State private var selectedWind: String = ""
    @State private var isWindSelected: Bool = false
    @State private var winds: [(key: String, value: String)] = [("Offshore", "Offshore"), ("Onshore" , "Onshore"), ("Side off", "Side off"), ("Side on", "Side on"), ("ClossShore", "ClossShore")]
    @State private var windStrengthSliderValue: Double = 0.0
                                    
    
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
                        
                        //Image select button
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
                        
                        //info form
                        Form {
                            
                            //wave size section
                            Section(header: Button(action: {
                                isSizeSelect.toggle()
                            }){
                                Text("Size")
                                    .headerProminence(.increased)
                                    .modifier(SectionButtonModifier(isSelected: $isSizeSelect))
                                
                                
                            })
                            {
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
                            
                            //wave condition section
                            Section(header:
                                        Button(action: {
                                isConditionSelect.toggle()
                            }){
                                Text("Conditon")
                                    .headerProminence(.increased)
                                    .modifier(SectionButtonModifier(isSelected: $isConditionSelect))
                            })
                            {
                                if isConditionSelect {
                                    Picker("", selection: $selectedCondition) {
                                        ForEach (waveConditions, id: \.key) { condition in
                                            Text(condition.value).tag(condition.key)
                                        }
                                    }.pickerStyle(.wheel)
                                        .labelsHidden()
                                        .frame(width: .infinity)
                                        .onChange(of: selectedCondition) {
                                            waveCondition = selectedCondition
                                            
                                            withAnimation{
                                                isConditionSelect = false
                                            }
                                        }
                                }
                                
                                Text(waveCondition)
                            }
                            
                            //swell
                            Section(header:
                                        Button(action: {
                                            isSwellSelected.toggle()
                            }){
                                Text("swell")
                                    .headerProminence(.increased)
                                    .modifier(SectionButtonModifier(isSelected: $isSwellSelected))
                            })
                            {
                                if isSwellSelected {
                                    Picker("", selection: $selectedSwell) {
                                        ForEach(swells, id: \.key) { swell in
                                            Text(swell.value).tag(swell.key)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    .labelsHidden()
                                    .frame(width: .infinity)
                                    .onChange(of: selectedSwell) {
                                        swell = selectedSwell
                                        withAnimation {
                                            isSwellSelected = false
                                        }
                                    }
                                }
                                //Logged swell
                                Text(swell)
                            }
                            
                            //wind direction
                            Section(header:
                                        Button(action: {
                                isWindSelected.toggle()
                            }){
                                Text("Wind")
                                    .headerProminence(.increased)
                                    .modifier(SectionButtonModifier(isSelected: $isWindSelected))
                            })
                            {
                                if isWindSelected {
                                    Picker("", selection: $selectedWind) {
                                        ForEach(winds, id: \.key) {
                                            wind in
                                            Text(wind.value)
                                                .tag(wind.key)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    .labelsHidden()
                                    .frame(maxWidth: .infinity)
                                    .onChange(of: selectedWind) {
                                        wind = selectedWind
                                        withAnimation{
                                            isWindSelected = false
                                        }
                                    }
                                }
                                    VStack {
                                        
                                        Text(wind)
                                        Spacer()
                                        SliderModifier(value: $windStrengthSliderValue, range: 0...100, gradient:  Gradient(colors: [.blue, .red]))
                                        
                                    }
                                
                                
                               
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
