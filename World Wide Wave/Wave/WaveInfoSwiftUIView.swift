//
//  WaveInfoSwiftUI.swift
//  World Wide Wave
//
//  Created by Ryuutarou Nakajima on 2024/12/02.
//

import SwiftUI
import MapKit

struct WaveInfoSwiftUIView: View {
    
    var coordinate: CLLocationCoordinate2D
    var timestamp: Date
    
    var body: some View {
        
        VStack {
            
            Text("latitude: \(coordinate.latitude)")
            
            Text("longitude:\(coordinate.longitude)")
            
            Text("\(timestamp)")
        }
    }
    
}

#Preview {
    
    let mockCoordinate = CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917)
    let mockTimestamp = Date()

    WaveInfoSwiftUIView(coordinate: mockCoordinate, timestamp: mockTimestamp)
}
