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
    @Published var mapPosition: MapCameraPosition = .automatic
    @Published var isToastShown: Bool = false
    @Published var distance: String = ""
    
    init() {
        self.setNextRound()
    }
    
    func setNextRound() {
        mapPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 40.484885,
                    longitude: -101.476607),
                span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)))
        targetLocation = CLLocationCoordinate2D(latitude: 37.0598, longitude: -104.8090)
        targetCity = "Alamosa Canyon"
    }
    
    func finishRound() {
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
        
        calculateDistanceBetweenCoordinates(coordinate1: pinLocation!, coordinate2: targetLocation!)
        isToastShown = true
    }
    
    
    func formatDistance(distance: CLLocationDistance) -> String {
        let formatter = MeasurementFormatter()
        let distanceMeasurement = Measurement(value: distance, unit: UnitLength.meters)
        
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 2
        
        let unit: UnitLength
        if distance < 1000 {
            unit = UnitLength.meters
        } else {
            unit = UnitLength.kilometers
        }
        
        let formattedDistance = formatter.string(from: distanceMeasurement.converted(to: unit))
        return formattedDistance
    }
    
    func calculateDistanceBetweenCoordinates(coordinate1: CLLocationCoordinate2D, coordinate2: CLLocationCoordinate2D) {
        let location1 = CLLocation(latitude: coordinate1.latitude, longitude: coordinate1.longitude)
        let location2 = CLLocation(latitude: coordinate2.latitude, longitude: coordinate2.longitude)
        
        let dist = location1.distance(from: location2)
        
        distance = formatDistance(distance: dist)
    }
    
    func nextRound() {
        isSubmitted = false
        pinLocation = nil
        setNextRound()
    }
}
