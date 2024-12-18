//
//  Struct tools.swift
//  World Wide Wave
//
//  Created by Ryuutarou Nakajima on 2024/12/18.
//

import SwiftUI

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

struct MediaFrameModifier: ViewModifier {
    
    var grayscaleAmount: Double = 0.7
    var cornerRadius: CGFloat = 10
    var shadowColor: Color = Color.black.opacity(0.2)
    var shadowRadius: CGFloat = 9
    var shadowOffsetX: CGFloat = 3
    var shadowOffsetY: CGFloat = 6
    
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .grayscale(grayscaleAmount)
            .cornerRadius(cornerRadius)
            .shadow(color: shadowColor, radius: shadowRadius, x: shadowOffsetX, y: shadowOffsetY)
           
    }
}

struct SectionBuutonModifier: ViewModifier {
    var shadowColor: Color = Color.black.opacity(0.6)
    var shadowRadius: CGFloat = 9
    var shadowOffsetX: CGFloat = 3
    var shadowOffsetY: CGFloat = 6
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(.white)
            .fontWeight(.bold)
            .shadow(color: shadowColor, radius: shadowRadius, x: shadowOffsetX, y: shadowOffsetY)
            .padding([.leading,.trailing])
            .background(.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            
    }
}
