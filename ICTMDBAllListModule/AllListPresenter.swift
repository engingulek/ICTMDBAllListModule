//
//  AllListPresenter.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 12.11.2025.
//

internal import GenericCollectionViewKit
internal import ICTMDBViewKit
import Foundation

enum SectionType: Int, CaseIterable {
    case tvShow
}

final class AllListPresenter {
    typealias CellItem = String
    
    weak var view:PresenterToViewAllListProtocol?
    private var interactor : PresenterToInteractorAllListProtocol
    private var router : PresenterToRouterAllListProtocol
    
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
    }
    
    func getAllList(at type: ListType) {
      
      
    }
    
    func numberOfRowsInSection(in section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else {return 0}
        switch sectionType {
        case .tvShow:
            return 5
        }
    }
    
    func numberOfSections() -> Int {
        SectionType.allCases.count
    }
    
    func cellForItem(section: Int, item: Int) -> String {
       return ""
    }
    
     func cellIdentifier(at section: Int) -> String {
         guard let section  = SectionType(rawValue: section) else {return ""}
         switch section {
         case .tvShow:
             return  TvShowCell.identifier
         }
    }
    
    func didSelectItem(section: Int, item: Int) {
        
    }

    
    func layout(for sectionIndex: Int) -> GenericCollectionViewKit.LayoutSource {
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
                    title:"\(LocalizableUI.tvShowCount.localized) ",
                    sizeType:.medium,buttonType:[])
            }
            return item
        }
    
    func scrollViewDidScroll(endOfPage: Bool) {
       
        
    }
}

//MARK: AllListPresenter : InteractorToPresenterAllListProtocol
extension AllListPresenter : @preconcurrency InteractorToPresenterAllListProtocol {
   
    func sendData() {
 
    }

  
    func sendError() {

    }

}
