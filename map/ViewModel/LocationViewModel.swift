//
//  LocationViewModel.swift
//  map
//
//  Created by funghi on 2022/6/27.
//

import Foundation
import SwiftUI
import MapKit
import FirebaseFirestore
import FirebaseStorage

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    //the firebase data
    @Published var locations: [Location] = []
    
    //Current region on map init user region
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    //Current location on Map
    @Published var mapLocation: Location?{
        didSet{
            updateMapRegion(location: mapLocation!)
        }
    }
    // Show location detail sheet
    @Published var sheetLocation: Bool = false
    
    //span the map
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServiceIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        }else{
            print("Show the alert letting them know this is off and to go turn it on")
        }
    }
    
    private func checkLocationAuthorization(){
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus{
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted likely due to parental controls. ")
            case .denied:
                print("You have denied this app location permission. Go into setting to change it.")
            case .authorizedAlways, .authorizedWhenInUse:
            mapRegion = MKCoordinateRegion(center: locationManager.location!.coordinate, span: mapSpan)
            @unknown default:
                break;
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
//    override init(){
//        self.mapLocation
//    }
    
    private func updateMapRegion(location: Location){
        withAnimation(.easeOut){
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
    }
    
    func showNextLocation(location: Location){
        withAnimation(.easeOut){
            mapLocation = location
        }
    }
    
    func nextButtonPressed(){
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation})
        else{
            print("Could not find current index in locations array! Should never happen.")
            return
        }
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex)else{
            guard let firstLocation = locations.first else{ return }
            showNextLocation(location: firstLocation)
            return
        }
        
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
    
    //get data from firebase firestore
    func getData(){
        Firestore.firestore().collection("TrashMap").getDocuments{(querySnapshot, err) in
            if let err = err{
                print("Error getting documnets: \(err)")
            }else{
                for document in querySnapshot!.documents{
                    let data = document.data()
                    let trashType = data["trashType"] as? String ?? ""
                    let imageName = data["imageName"] as? String ?? ""
                    let imageUrl = data["imageUrl"] as? String ?? ""
                    let coordinate = data["coordinate"] as? GeoPoint
                    print("\(document.documentID) => \(document.data())")
                    self.locations.append(Location(imageName: imageName, imageUrl: imageUrl, trashType: trashType, coordinates: CLLocationCoordinate2D(latitude: coordinate?.latitude ?? 0, longitude: coordinate?.longitude ?? 0)))
                }
                self.mapLocation = self.locations.first!
            }
        }
    }
}

