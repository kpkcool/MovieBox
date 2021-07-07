//
//  HomeViewModel.swift
//  Movie Box
//
//  Created by K Praveen Kumar on 07/07/21.
//

import SwiftUI

class UpcomingAndTopRatedViewModel: ObservableObject {
    @Published var items: [Movie]?
    
    public var placeholders = Array(repeating: Movie(id: Int(UUID().uuidString), overview: nil, title: nil), count: 10)
    
    func fetchData(sortBy: String, listType: String) {
        let url = URL(string: "\(Constants.baseURl)/movie/\(listType)?api_key=\(Constants.apiKey)&language=en-US&sort_by=\(sortBy)&include_adult=false&include_video=false&page=1")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                do {
                    let res: ErrorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data!)
                    print("Error while fetching the data", res.status_message!)
                    return
                } catch {
                    print(error)
                }
            }
            
            guard let data = data else { return }
            
            do {
                let result: DiscoverResponse = try JSONDecoder().decode(DiscoverResponse.self, from: data)
                DispatchQueue.main.async {
                    self.items = result.results
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}

