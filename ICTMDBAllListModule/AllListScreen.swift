//
//  SwiftUIView.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import SwiftUI
import ICTMDBViewKit
import ICTMDBNavigationManagerSwiftUI
struct AllListScreen<VM: AllListViewModelProtocol>: View {
    @StateObject var viewModel: VM
    @EnvironmentObject private var navigation:Navigation
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
                                    .onTapGesture {
                                        viewModel.onTappedItem(id: item.id)
                                    }
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
                }.onAppear{
                    viewModel.toDetail = { id in
                        navigation.push(.detail(id))
                    }
                }
            }
        }
    }
}

#Preview("Popular") {
    let module = ICTMDBAllListModule()
    module.createAllListModule(type: .popular)
}


#Preview("Airing Today") {
    let module = ICTMDBAllListModule()
    module.createAllListModule(type: .airingToday)
}

