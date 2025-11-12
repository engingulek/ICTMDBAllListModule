//
//  AllListPresenter.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 12.11.2025.
//
 import GenericCollectionViewKit
 import ICTMDBViewKit
import Foundation

enum SectionType: Int, CaseIterable {
    case tvShow
}

final class AllListPresenter {
    typealias CellItem = TVShowPresentation
    
    weak var view:PresenterToViewAllListProtocol?
    private var interactor : PresenterToInteractorAllListProtocol
    private var router : PresenterToRouterAllListProtocol
    private var currentPage:Int = 1
    private var totalPage:Int = 1
    private var listtype:ListType? = nil
    private var tvShows : [TVShowPresentation] = []
    
    init(view: PresenterToViewAllListProtocol?,
         interactor:PresenterToInteractorAllListProtocol,
         router:PresenterToRouterAllListProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

//MARK: AllListPresenter : ViewToPresenterAllListProtocol
extension AllListPresenter : ViewToPresenterAllListProtocol {
 
    
    func viewDidLoad() {
        view?.setBackColorAble(color: "backColor")
        view?.setNavigationTitle(title: "All List")
    }
    
    func getAllList(at type: ListType) {
        listtype = type
        interactor.loadTvShows(type: type, page: currentPage)
      
    }
    
    func numberOfRowsInSection(in section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else {return 0}
        switch sectionType {
        case .tvShow:
            return tvShows.count
        }
    }
    
    func numberOfSections() -> Int {
        SectionType.allCases.count
    }
    
    func cellForItem(section: Int, item: Int) -> TVShowPresentation {
        let tvShow = tvShows[item]
        return tvShow
    }
    
     func cellIdentifier(at section: Int) -> String {
        guard let section  = SectionType(rawValue: section) else {return ""}
        switch section {
        case .tvShow:
            return  TvShowCell.identifier
        }
    }
    func didSelectItem(section: Int, item: Int) {
        guard let section  = SectionType(rawValue: section) else {return}
        switch section {
        case .tvShow:
            let id = tvShows[item].id
            router.toDetail(view: view, id: id)
        }
    }
    
   
    
    func layout(for sectionIndex: Int) -> LayoutSource {
        
        guard let sectionType = SectionType(rawValue: sectionIndex) else {
            return LayoutSourceTeamplate.none.template
        }
        switch sectionType {
        case .tvShow:
            return LayoutSourceTeamplate.verticalTwoPerRow.template
        }
    }
    
    func titleForSection(at section: Int) -> (
        title: String, sizeType:SectionSizeType,
        buttonType: [TitleForSectionButtonType]?) {
            guard let sectionType = SectionType(rawValue: section)
            else { return  (title:"",sizeType:.small,buttonType:[]) }
            
            var item : (
                title: String,
                sizeType: SectionSizeType,buttonType: [TitleForSectionButtonType]?)
            
            switch sectionType {
            case .tvShow:
                item = (
                    title:"\(LocalizableUI.tvShowCount.localized) \(tvShows.count)",
                    sizeType:.medium,buttonType:[])
            }
            return item
        }
    
    func scrollViewDidScroll(endOfPage: Bool) {
        guard let listtype = listtype else {return}
        if endOfPage {
            if currentPage <= totalPage {
                currentPage += 1
                interactor.loadTvShows(type: listtype , page: currentPage)
                view?.relaodCollectionView()
            }
        }
        
    }
}

//MARK: AllListPresenter : InteractorToPresenterAllListProtocol
extension AllListPresenter : @preconcurrency InteractorToPresenterAllListProtocol {
    @MainActor
    func sendData(_ data: DataResult<TvShow>) {
      
            
        view?.startLoading()
            self.totalPage = data.totalPages
            self.tvShows.append(contentsOf: data.results.map {
                TVShowPresentation(tvShow: $0)
            }.sorted {
                self.listtype == .popular ? $0.rating > $1.rating : true
            })
       
       
        view?.finishLoading()
        view?.prepareCollectionView()
        view?.relaodCollectionView()
        
    }

    @MainActor
    func sendError() {
        
            
        view?.startLoading()
           tvShows = []
        view?.relaodCollectionView()
        view?.sendErrorState(state: (isHidden: true, message: LocalizableUI.somethingWentWrong.localized))
        view?.finishLoading()
        
    }

}
