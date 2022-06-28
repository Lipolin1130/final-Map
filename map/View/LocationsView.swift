//
//  LocationsView.swift
//  map
//
//  Created by funghi on 2022/6/28.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    @EnvironmentObject private var vm: LocationViewModel
    var body: some View {
        ZStack{
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                locationsPreviewStack
                Spacer()
                HStack{
                    Spacer()
                    Button {
                        vm.sheetLocation.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline)
                            .padding(16)
                            .foregroundColor(.white)
                            .background(Color.blue.opacity(10))
                            .cornerRadius(10)
                            .shadow(radius: 4)
                            .padding()
                    }
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $vm.sheetLocation){
            DetailView()
        }
        .onAppear{
            vm.getData()
            vm.checkIfLocationServiceIsEnabled()
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationViewModel())
    }
}

extension LocationsView{
    private var mapLayer: some View{
        Map(coordinateRegion: $vm.mapRegion,showsUserLocation: true, annotationItems:vm.locations, annotationContent: {location in
            MapAnnotation(coordinate: location.coordinates){
                LocationMapAnnotationView(name: location.imageName)
                    .shadow(radius: 10)
                    .onTapGesture{
                        vm.showNextLocation(location: location)
                    }
            }
        })
    }
    
    private var locationsPreviewStack: some View{
        ZStack{
            ForEach(vm.locations){location in
                if vm.mapLocation == location{
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}
