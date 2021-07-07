//
//  FeaturedMoviesView.swift
//  Movie Box
//
//  Created by K Praveen Kumar on 07/07/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FeaturedMoviesView: View {
    @ObservedObject private var viewModel = UpcomingAndTopRatedViewModel()
    @State var pageSelected: Int = 0
    
    var body: some View {
        ZStack {
            if viewModel.items != nil {
                TabView(selection: $pageSelected) {
                    ForEach(0..<4) { index in
                        FeaturedTab(item: (viewModel.items?[index])!, index: index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Image(systemName: "play.circle")
                        .font(.system(size: 45))
                        .foregroundColor(Color("yellow"))
                        .shadow(color: Color.black, radius: 5)
                    
                    Text("Movie")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading, 8)
                    
                    Text("Box")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                
                Spacer()
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    ForEach(0..<4) { index in
                        Capsule()
                            .frame(width: 22, height: 6)
                            .foregroundColor(pageSelected == index ? .yellow : .gray)
                    }
                }
                .padding()
                .padding(.bottom, 30)
                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.124825187, green: 0.1294132769, blue: 0.1380611062, alpha: 1)), Color.clear]), startPoint: .bottom, endPoint: .top))
            }
        }
        .frame(height: UIScreen.main.bounds.height / 1.8)
        .onAppear {
            viewModel.fetchData(sortBy: "popularity.desc", listType: "top_rated")
        }
    }
}

struct FeaturedTab: View {
    var item: Movie
    var index: Int
    
    var body: some View {
        NavigationLink(
            destination: MovieDetailsView(item: item),
            label: {
                ZStack(alignment: .bottomLeading) {
                    WebImage(url: URL(string: "\(Constants.imagesBaseUrl)\(item.backdrop_path ?? "")"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width)
                        .clipped()
                        .tag(index)
                        
                    VStack(alignment: .leading) {
                        Text(item.title ?? "Loading...")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.leading)
                            
                        Text("Top Featured Movies")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                            .padding(.leading)
                    }
                    .padding(.bottom, 40)
                }
            })
    }
}

struct FeaturedMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FeaturedMoviesView()
                
            Spacer()
        }
        .background(Color("background"))
        .ignoresSafeArea(.all, edges: .top)
    }
}
