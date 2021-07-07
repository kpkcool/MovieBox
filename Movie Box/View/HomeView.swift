//
//  HomeView.swift
//  Movie Box
//
//  Created by K Praveen Kumar on 07/07/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    FeaturedMoviesView()
                    
                    MoviesListView(title: "Upcoming Movies", sortBy: "release_date.desc", orientation: "vertical")

                    MoviesListView(title: "Top Rated Movies", sortBy: "popularity.desc")

                    
                }
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            })
            .background(Color("background"))
            .navigationBarHidden(true)
            .ignoresSafeArea(.all, edges: .all)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
