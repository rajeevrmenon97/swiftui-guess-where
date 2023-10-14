//
//  GeoNamesApiService.swift
//  GuessWhere
//
//  Created by Rajeev R Menon on 10/13/23.
//

import Foundation


struct GeoNamesApiResponse: Codable, Identifiable {
    var id: UUID {UUID()}
    var major: Major
}

struct Major: Codable, Identifiable {
    var id: UUID {UUID()}
    var name: String
    var inlatt: String
    var inlongt: String
}
