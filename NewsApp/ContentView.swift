//
//  ContentView.swift
//  NewsApp
//
//  Created by Demetrius Vissarion on 14/02/2024.
//

import SwiftUI

struct Item: Codable, Identifiable {
    let id: Int
    var title: String
    var body: String
}

struct ContentView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        HStack {
            Text("NewsApp")
                .font(.system(size: 40, weight: .light, design: .serif))
        }
        .frame(maxWidth: .infinity)
        .background(Color.blue.opacity(0.7))
        .padding(.horizontal, 0)
        .padding(.vertical, 0)
        
        VStack {
            List(viewModel.allNews) { item in
                VStack {
                    Text(item.title.capitalized).font(.system(size: 14, weight: .bold, design: .serif )).multilineTextAlignment(.leading)
                    Spacer()
                    Text(item.body.capitalized)
                        .font(.system(size: 10, weight: .light, design: .serif)).multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding()
            }
            .onAppear {
                viewModel.fetchData()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
