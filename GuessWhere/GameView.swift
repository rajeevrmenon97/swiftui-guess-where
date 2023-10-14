//
//  GameView.swift
//  GuessWhere
//
//  Created by Rajeev R Menon on 10/12/23.
//

import SwiftUI
import MapKit
import AlertToast

struct GameView: View {
    
    @StateObject private var gameViewModel = GameViewModel()
    @State private var buttonLabel = "Submit"
    
    let subLabel = "Submit"
    let nextLabel = " Next "
    
    var body: some View {
        GeometryReader { geometryReader in
            VStack {
                MapView(gameViewModel: gameViewModel)
                    .cornerRadius(20)
                    .padding([.leading, .trailing, .bottom])
                
                HStack {
                    
                    HStack {
                        Image(systemName: "gear")
                        Text("Timer")
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            if buttonLabel == subLabel {
                                if gameViewModel.pinLocation != nil {
                                    gameViewModel.finishRound()
                                    buttonLabel = nextLabel
                                }
                            } else {
                                buttonLabel = subLabel
                                gameViewModel.nextRound()
                            }
                        }
                    }, label: {
                        Text(buttonLabel)
                    })
                    .buttonStyle(.bordered)
                }
                .padding([.leading, .trailing])
            }
        }
        .toast(isPresenting: $gameViewModel.isToastShown){
            AlertToast(type: .complete(.primary), title: "You were \(gameViewModel.distance) away")
        }
        .navigationTitle(gameViewModel.targetCity != nil ? gameViewModel.targetCity!: "Loading..")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        GameView()
    }
}
