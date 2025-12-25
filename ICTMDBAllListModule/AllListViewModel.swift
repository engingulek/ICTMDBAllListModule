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
    var toDetail:((Int?) -> Void)?  { get set }
    func onTappedItem(id:Int?)
}


final class AllListViewModel : AllListViewModelProtocol {
    
    @Published var tvShows : [TVShowPresentation]  = []
    private var tvShowsWithPage:  [(page:Int,list:[TVShowPresentation])] = []
    @Published var isLoading: Bool = false
    private let service : AllListServiceProtocol
    @Published var currentPage:Int = 1
    @Published var totalPage:Int = 1
    @Published var isError: (state: Bool, message: String) = (false, "")
    var toDetail:((Int?)->Void)?
    private var listType:ListType? = nil
    
    init( service: AllListServiceProtocol) {
        self.service = service
    }
    
    func loadData(type:ListType) {
        listType = type
        isLoading = true
        service.loadTvShows(type:type , page: currentPage) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let list = data.results.map {
                    TVShowPresentation(tvShow: $0)}.sorted {
                        type == .popular ? $0.rating > $1.rating : true
                    }
                
                tvShowsWithPage.append((page: data.page, list: list))
                tvShows = list
                totalPage = data.totalPages
                isLoading = false
                isError = (state:false,message:"")
            case .failure:
                isLoading = false
                isError = (state:true,message:LocalizableUI.somethingWentWrong.localized)
            }
        }
    }
    
    func prevPage() {
        if currentPage >= 2 {
            currentPage -= 1
            tvShows = tvShowsWithPage
                .first(where: { $0.page == currentPage })?.list ?? []
        }
    }
    
    func nextPage() {
        guard let listType else {return}
        if currentPage <= totalPage {
            currentPage += 1
            loadData(type:listType )
        }
    }
    
    func onTappedItem(id: Int?) {
        toDetail?(id)
    }
}

