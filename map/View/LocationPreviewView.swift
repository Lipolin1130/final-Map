//
//  LocationPreviewView.swift
//  map
//
//  Created by funghi on 2022/6/28.
//

import SwiftUI
import SDWebImageSwiftUI

struct LocationPreviewView: View {
    @EnvironmentObject  private var vm : LocationViewModel
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0){
            
            VStack(alignment: .leading, spacing: 16){
                imageSection
            }
            VStack(alignment: .center, spacing: 8){
                
                HStack{
                    titleSection
                    closeButton
                }
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
            AnimatedImage(url: URL(string: location.imageUrl))
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
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
    
    private var closeButton: some View{
        Button{
            vm.previewLocation.toggle()
        }label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(8)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
}
