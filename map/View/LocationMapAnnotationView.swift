//
//  LocationMapAnnotationView.swift
//  map
//
//  Created by funghi on 2022/6/28.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    let name: String
    var body: some View {
        VStack(spacing: 0){
            Text("\(name)")
                .foregroundColor(.green)
                .font(.caption)
            Image(systemName: "trash.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(Color.white)
                .padding(6)
                .background(Color.green)
                .clipShape(Circle())
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.green)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
            
        }
    }
}
