//
//  SwiftUIView.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import SwiftUI
import Kingfisher
import SwiftUI
import Kingfisher

struct AllListScreen<VM: AllListViewModelProtocol>: View {
    @StateObject var viewModel: VM
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
      
        ZStack(alignment: .bottom) { // 1. Hizalamayı bottom yapıyoruz
            ScrollView {
                LazyVStack(spacing: 16) {
                    // Header - Sayaç Kısmı
                    HStack {
                        Text("TvShowCount \(viewModel.tvShows.count)")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Grid Yapısı
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.tvShows, id: \.id) { item in
                            VStack(spacing: 0) {
                                // ... Mevcut Kart Tasarımın ...
                                ZStack(alignment: .topTrailing) {
                                    KFImage(URL(string: item.mainPoster))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 220)
                                        .frame(maxWidth: .infinity)
                                        .clipped()
                                        .overlay(alignment: .topTrailing) {
                                            Text(item.flag)
                                                .padding([.top, .trailing], 8)
                                        }
                                        .overlay(alignment: .bottomTrailing) {
                                            RatingView(score: item.rating, type: .airingToday)
                                                .padding([.bottom, .trailing], 8)
                                        }
                                    
                                    Text(item.flag)
                                        .font(.system(size: 18))
                                        .cornerRadius(6)
                                        .padding([.top, .trailing], 8)
                                }
                                
                                Text(item.title)
                                    .font(.system(size: 16, weight: .bold))
                                    .padding(.vertical, 12)
                                    .frame(height: 60)
                            }
                            .background(Color(.secondarySystemGroupedBackground))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 2)
                        }
                    }
                    .padding(.horizontal)
                    
                    // ScrollView'un en altında boşluk bırakıyoruz ki
                    // sabit duran view son elemanı kapatmasın
                    Color.clear.frame(height: 80)
                }
            }

            PaginationView(
                currentPage: viewModel.currentPage,
                totalPages: viewModel.totalPage,
                prevAction: viewModel.prevPage, nextAction: viewModel.nextPage)
           
            
           
        }
          
        
    }
}

#Preview("Popular") {
    ICTMDBAllListModule.createModule(type:ListType.popular)
}

