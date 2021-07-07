//
//  MovieDetailsView.swift
//  Movie Box
//
//  Created by K Praveen Kumar on 07/07/21.
//

import SwiftUI

import SDWebImageSwiftUI

struct MovieDetailsView: View {
    var item: Movie
    
    @ObservedObject private var viewModel = MovieDetailsViewModel()
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(alignment: .leading) {
                WebImage(url: URL(string: "\(Constants.imagesBaseUrl)\(item.backdrop_path ?? "")"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                    .clipped()
                    .overlay(
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Button(action: {
                                    presentation.wrappedValue.dismiss()
                                }, label: {
                                    Image(systemName: "arrow.left")
                                        .font(.system(size: 32))
                                        .foregroundColor(Color("yellow"))
                                })
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top, 40)
                            
                            Spacer()
                            
                            Text(item.title ?? "Loading...")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            Text("Release Date  : \(viewModel.movie?.release_date ?? "")")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                                .redacted(reason: viewModel.movie?.release_date == nil ? .placeholder : .init())
                                .padding(.horizontal)
                            
                            Text("Rating  : \(Int(viewModel.movie?.vote_average ?? 0) )")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                                .redacted(reason: viewModel.movie?.vote_average == nil ? .placeholder : .init())
                                .padding(.horizontal)
                                
                            HStack(spacing: 8) {
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.124825187, green: 0.1294132769, blue: 0.1380611062, alpha: 1)), Color.clear]), startPoint: .bottom, endPoint: .top))
                    )
                
                Text(viewModel.movie?.overview ?? "Loading...")
                    .foregroundColor(.gray)
                    .redacted(reason: viewModel.movie?.overview == nil ? .placeholder : .init())
                    .padding()
                
                Spacer()
            }
        })
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .background(Color("background"))
        .ignoresSafeArea(.all, edges: .all)
        .onAppear {
            viewModel.fetchData(id: item.id!)
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(item: Movie(id: 0, backdrop_path: "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg", overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi auctor ligula dui, sit amet fermentum enim varius sed. Cras ultrices sodales ullamcorper. Nulla accumsan laoreet est in malesuada. Ut elementum condimentum rutrum. Pellentesque in mi in lorem congue placerat id euismod nisi. Donec at lacus sem. Curabitur tristique, mi in tincidunt sagittis, felis nisl tempor arcu, sit amet commodo arcu leo a nulla. Vivamus blandit diam sit amet nulla feugiat, at ultricies turpis mollis. Curabitur eleifend pulvinar ultricies. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus at sapien eros. Nunc vel facilisis neque.", poster_path: "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", release_date: "21-10-85", title: "The Awesome Movie"))
    }
}

