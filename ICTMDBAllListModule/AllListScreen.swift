//
//  SwiftUIView.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import SwiftUI
import ICTMDBViewKit

struct AllListScreen<VM: AllListViewModelProtocol>: View {
    @StateObject var viewModel: VM
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .font(.largeTitle)
                .foregroundStyle(.black)
        }else{
            if viewModel.isError.state {
                AppText(text: viewModel.isError.message, style: .error)
            }else{
                ZStack(alignment: .bottom) {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.tvShows, id: \.id) { item in
                                TvShowItem(item: item)
                            }
                        }
                        .padding(.horizontal)
                        Color.clear.frame(height: 80)
                    }
                    PaginationView(
                        currentPage: viewModel.currentPage,
                        totalPages: viewModel.totalPage,
                        prevAction: viewModel.prevPage,
                        nextAction: viewModel.nextPage)
                }
            }
        }
    }
}

#Preview("Popular") {
    ICTMDBAllListModule.createModule(type:ListType.popular)
}

