//
//  MapView.swift
//  GuessWhere
//
//  Created by Rajeev R Menon on 10/13/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var gameViewModel: GameViewModel
    
    var body: some View {
        MapReader { mapReader in

            
            Map(position: $gameViewModel.mapPosition) {
                if gameViewModel.pinLocation != nil {
                    Marker("Your pin", coordinate: gameViewModel.pinLocation!)
                }
                
                if gameViewModel.isSubmitted {
                    Marker(gameViewModel.targetCity!, coordinate: gameViewModel.targetLocation!)
                    MapPolyline(coordinates: [gameViewModel.pinLocation!, gameViewModel.targetLocation!])
                        .stroke(.black)
                        
                }
            }
            .onTapGesture(perform: { screenCoordinates in
                if !gameViewModel.isSubmitted, let coordinates = mapReader.convert(screenCoordinates, from: .local) {
                    gameViewModel.pinLocation = coordinates
                }
            })
        }
    }
}

