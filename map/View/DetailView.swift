//
//  DetailView.swift
//  map
//
//  Created by funghi on 2022/6/28.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject private var vm: LocationViewModel
    @State var imageName: String = ""
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 16){
                Text("hello")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topTrailing)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

extension DetailView{
    private var backButton: some View{
            Button {
                vm.sheetLocation.toggle()
            } label: {
                Image(systemName: "xmark")
                    .font(.headline)
                    .padding(16)
                    .foregroundColor(.primary)
                    .background(.thickMaterial)
                    .cornerRadius(10)
                    .shadow(radius: 4)
                    .padding()
            }
    }
}
