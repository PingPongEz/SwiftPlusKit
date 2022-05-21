//
//  ContentView.swift
//  SwiftPlusKit
//
//  Created by Сергей Веретенников on 20/05/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentValue: Float = 0
    @State private var targetValue = 0
    @State private var score = 0
    @State private var isPresented = false
    
    var body: some View {
        
        VStack {
            Text("Сдвинь меня ближе к: \(targetValue)")
                .font(.system(size: 13))
                .padding(.bottom, 16)
            
            HStack {
                Text("0")
                    .frame(width: 29)
                    .padding(.leading, 16)
                
                SwiftUIView(sliderValue: $currentValue, targetValue: $targetValue, score: $score)
                
                Text("100")
                    .frame(width: 29)
                    .padding(.trailing, 16)
            }
            .padding(.bottom, 16)
            
            HStack {
                ResultButton(isPresented: $isPresented)
                    .padding(.leading, 100)
                
                Spacer()
                
                NewGameButton(action: shufle)
                    .padding(.trailing, 100)
            }
        }
        .alert("Score alert!", isPresented: $isPresented, actions: {}) {
            Text("Your score is \(score)")
                .font(.system(size: 10))
                .foregroundColor(.black)
        }
        .onAppear {
            shufle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    private func shufle() {
        withAnimation(.linear) {
            currentValue = Float.random(in: 0...100)
            targetValue = Int.random(in: 0...100)
            score = 100 - (abs(targetValue - lroundf(currentValue)))
        }
    }
}

struct ResultButton: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        Button {
            isPresented = true
        } label: {
            Text("Show result")
                .font(.system(size: 13))
                .foregroundColor(.blue)
        }
    }
}

struct NewGameButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("New game")
                .font(.system(size: 13))
                .foregroundColor(.green)
        }
    }
}
