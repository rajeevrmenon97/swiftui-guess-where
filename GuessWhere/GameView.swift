//
//  GameView.swift
//  GuessWhere
//
//  Created by Rajeev R Menon on 10/12/23.
//

import SwiftUI
import MapKit

struct GameView: View {
    
    @StateObject private var gameViewModel = GameViewModel()
    
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
                    
                    VStack {
                        Button(action: {
                            withAnimation {
                                gameViewModel.finishTurn()
                            }
                        }, label: {
                            Text("Submit")
                        })
                        .buttonStyle(.bordered)
                    }
                }
                .padding([.leading, .trailing])
                
            }
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
