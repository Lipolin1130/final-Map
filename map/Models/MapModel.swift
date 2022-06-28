//
//  MapViewModel.swift
//  map
//
//  Created by funghi on 2022/6/27.
//

import SwiftUI
import MapKit

struct Location: Identifiable, Equatable{
    let id = UUID()
    let imageName: String
    let imageUrl: String
    let trashType: String
    let coordinates: CLLocationCoordinate2D
    
    static func == (lhs: Location, rhs: Location) -> Bool{
        lhs.id == rhs.id
    }
}
