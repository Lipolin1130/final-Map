//
//  mapApp.swift
//  map
//
//  Created by funghi on 2022/6/26.
//

import SwiftUI
import Firebase

@main
struct mapApp: App {
    
    @StateObject private var vm = LocationViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
