//
//  AllListViewModel.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import Foundation
import ICTMDBViewKit
protocol AllListViewModelProtocol  : ObservableObject{
    var tvShows : [TVShowPresentation] {get}
    var isLoading:Bool {get}
    var isError: (state:Bool,message:String) {get}
    func loadData(type:ListType)
    var currentPage:Int {get}
        var totalPage:Int {get}
    func prevPage()
    func nextPage()
}


final class AllListViewModel : AllListViewModelProtocol {
  
    @Published var tvShows : [TVShowPresentation]  = []
    private var tvShowsWithPage:  [(page:Int,list:[TVShowPresentation])] = []
    @Published var isLoading: Bool = false
    private let service : AllListServiceProtocol
    @Published var currentPage:Int = 1
    @Published var totalPage:Int = 1
    @Published var isError: (state: Bool, message: String) = (false, "")
    private var listType:ListType? = nil
    
    init( service: AllListServiceProtocol) {
        self.service = service
    }
    
    func loadData(type:ListType) {
        listType = type
        isLoading = true
        service.loadTvShows(type:type , page: currentPage) { result in
            
            switch result {
            case .success(let data):
                let list = data.results.map {
                    TVShowPresentation(tvShow: $0)}.sorted {
                        type == .popular ? $0.rating > $1.rating : true
                    }

                self.tvShowsWithPage.append((page: data.page, list: list))
                self.tvShows = list
                self.totalPage = data.totalPages
                self.isLoading = false
                self.isError = (state:false,message:"")
            case .failure:
                self.isLoading = false
                self.isError = (state:true,message:LocalizableUI.somethingWentWrong.localized)
            }
        }
    }
    
    func prevPage() {
        if currentPage >= 2 {
            currentPage -= 1
           self.tvShows = self.tvShowsWithPage
                .first(where: { $0.page == self.currentPage })?.list ?? []
        }
    }
    
    func nextPage() {
        guard let listType else {return}
        if currentPage <= totalPage {
            currentPage += 1
            loadData(type:listType )
        }
    }
}

