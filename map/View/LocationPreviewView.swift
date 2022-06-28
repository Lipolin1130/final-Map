//
//  LocationPreviewView.swift
//  map
//
//  Created by funghi on 2022/6/28.
//

import SwiftUI

struct LocationPreviewView: View {
    @EnvironmentObject  private var vm : LocationViewModel
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0){
            
            VStack(alignment: .leading, spacing: 16){
                imageSection
            }
            VStack(alignment: .center, spacing: 8){
                titleSection
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
        )
        .cornerRadius(10)
    }
}

extension LocationPreviewView{
    private var imageSection: some View{
        ZStack{
            Image(location.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View{
        VStack(alignment: .center, spacing: 4){
            Text(location.imageName)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.trashType)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private var nextButton: some View{
        Button{
            vm.nextButtonPressed()
        }label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}
