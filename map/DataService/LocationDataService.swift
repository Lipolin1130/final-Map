//
//  LocationDataService.swift
//  map
//
//  Created by funghi on 2022/6/28.
//

import SwiftUI
import MapKit

class LocationDataService{
    static let locations: [Location] = [
        Location(imageName: "trash1", imageUrl: "", trashType: "plastic", coordinates: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922)),
        Location(imageName: "trash2", imageUrl: "", trashType: "paper", coordinates: CLLocationCoordinate2D(latitude: 41.8906, longitude: 12.4769)),
    ]
}
