//
//  SwiftUIView.swift
//  SwiftPlusKit
//
//  Created by Сергей Веретенников on 20/05/2022.
//

import SwiftUI

struct SwiftUIView: UIViewRepresentable {
    
    @Binding var sliderValue: Float
    @Binding var targetValue: Int
    @Binding var score: Int
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        
        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
        slider.setValue(sliderValue, animated: true)
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.didSliderDone),
            for: .valueChanged
        )
        slider.thumbTintColor = .red
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
            uiView.setValue(sliderValue, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(sliderValue: $sliderValue, targetValue: $targetValue, score: $score)
    }
}

extension SwiftUIView {
    class Coordinator: NSObject {
        @Binding var sliderValue: Float
        @Binding var targetValue: Int
        @Binding var score: Int
        
        init(sliderValue: Binding<Float>, targetValue: Binding<Int>, score: Binding<Int>) {
            self._sliderValue = sliderValue
            self._targetValue = targetValue
            self._score = score
        }
        
        private func setSliderOpp(_ sender: UISlider) {
            let diff = 100 - (abs(targetValue - lroundf(sliderValue)))
            sender.thumbTintColor = UIColor(red: 1, green: 0, blue: 0, alpha: CGFloat(diff) / 100)
            score = diff
        }
        
        @objc func didSliderDone(_ sender: UISlider) {
            sliderValue = sender.value
            setSliderOpp(sender)
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView(sliderValue: .constant(10))
//    }
//}
