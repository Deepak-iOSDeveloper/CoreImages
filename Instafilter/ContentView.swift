//
//  ContentView.swift
//  Instafilter
//
//  Created by DEEPAK BEHERA on 28/06/25.
//
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image1: Image?
    @State private var image2: Image?
    @State private var image3: Image?
    @State private var image4: Image?
    var body: some View {
        VStack {
            image1?
                .resizable()
                .scaledToFit()
            image2?
                .resizable()
                .scaledToFit()
            image3?
                .resizable()
                .scaledToFit()
            image4?
                .resizable()
                .scaledToFit()
            
        }.onAppear(perform: loadImage)
        
    }
    func loadImage() {
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter1 = CIFilter.sepiaTone()
        
        currentFilter1.inputImage = beginImage
        currentFilter1.intensity  = 1
        
        guard let outputImage = currentFilter1.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let uiImage = UIImage(cgImage: cgImage)
        image1 = Image(uiImage: uiImage)
        
        // --------
        let currentFilter2 = CIFilter.pixellate()
        
        currentFilter2.inputImage = beginImage
        currentFilter2.scale  = 100
        
        guard let outputImage = currentFilter2.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let uiImage2 = UIImage(cgImage: cgImage)
        image2 = Image(uiImage: uiImage2)
        
        // --------
        let currentFilter3 = CIFilter.crystallize()
        
        currentFilter3.inputImage = beginImage
        currentFilter3.radius  = 200
        
        guard let outputImage = currentFilter3.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let uiImage3 = UIImage(cgImage: cgImage)
        image3 = Image(uiImage: uiImage3)
        
        // --------
        let currentFilter4 = CIFilter.twirlDistortion()
        
        currentFilter4.inputImage = beginImage
        currentFilter4.radius  = 1000
        currentFilter4.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)
        let amount = 1.0
        let inputKeys = currentFilter4.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter4.setValue(amount, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter4.setValue(amount * 10, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter4.setValue(amount * 200, forKey: kCIInputRadiusKey)
        }
        guard let outputImage = currentFilter4.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let uiImage4 = UIImage(cgImage: cgImage)
        image4 = Image(uiImage: uiImage4)
    }
}

#Preview {
    ContentView()
}
