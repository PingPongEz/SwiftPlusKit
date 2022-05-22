//
//  SwiftUIView.swift
//  SwiftPlusKit
//
//  Created by Сергей Веретенников on 20/05/2022.
//

import SwiftUI

struct SwiftUIView: UIViewRepresentable {
    
    @Binding var sliderValue: Float
    let sliderOpp: Int
    let color: UIColor
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        
        slider.minimumValue = 1.0
        slider.maximumValue = 100.0
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.didSliderDone),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.thumbTintColor = color.withAlphaComponent(CGFloat(sliderOpp) / 100)
        uiView.setValue(sliderValue, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(sliderValue: $sliderValue)
    }
}

extension SwiftUIView {
    class Coordinator: NSObject {
        @Binding var sliderValue: Float
        
        init(sliderValue: Binding<Float>) {
            self._sliderValue = sliderValue
        }
        
        @objc func didSliderDone(_ sender: UISlider) {
            sliderValue = sender.value
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(sliderValue: .constant(10), sliderOpp: 50, color: .green)
    }
}
