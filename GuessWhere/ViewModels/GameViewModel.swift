//
//  GameViewModel.swift
//  GuessWhere
//
//  Created by Rajeev R Menon on 10/13/23.
//

import Foundation
import MapKit
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var pinLocation: CLLocationCoordinate2D? = nil
    @Published var targetLocation: CLLocationCoordinate2D? = nil
    @Published var isSubmitted: Bool = false
    @Published var targetCity: String? = nil
    @Published var mapPosition: MapCameraPosition
    
    init() {
        targetLocation = CLLocationCoordinate2D(latitude: 37.0598, longitude: -104.8090)
        targetCity = "Alamosa Canyon"
        mapPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 40.484885,
                    longitude: -101.476607),
                span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)))
    }
    
    func finishTurn() {
        if pinLocation != nil {
            isSubmitted = true
            let minLat = min(pinLocation!.latitude, targetLocation!.latitude)
            let maxLat = max(pinLocation!.latitude, targetLocation!.latitude)
            let minLon = min(pinLocation!.longitude, targetLocation!.longitude)
            let maxLon = max(pinLocation!.longitude, targetLocation!.longitude)
            
            let center = CLLocationCoordinate2D(
                latitude: (minLat + maxLat) / 2,
                longitude: (minLon + maxLon) / 2
            )
            
            let span = MKCoordinateSpan(
                latitudeDelta: (maxLat - minLat) * 1.5,
                longitudeDelta: (maxLon - minLon) * 1.5
            )
            
            mapPosition = MapCameraPosition.region(MKCoordinateRegion(center: center, span: span))
        }
    }
}
