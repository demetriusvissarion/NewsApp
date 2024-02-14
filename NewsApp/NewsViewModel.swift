//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Demetrius Vissarion on 14/02/2024.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var allNews = [Item]()
    
    func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                if var items = try? JSONDecoder().decode([Item].self, from: data) {
                    items = items.map { item in
                        var newItem = item
                        newItem.title = newItem.title.replacingOccurrences(of: "\n", with: " ")
                        newItem.body = newItem.body.replacingOccurrences(of: "\n", with: " ")
                        return newItem
                    }
                    self?.allNews.append(contentsOf: items)
                }
            }
        }.resume()
    }
}
