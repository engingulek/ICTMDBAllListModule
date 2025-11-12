//
//  ICTMDBAllListModule.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import Foundation

import UIKit
 import ICTMDBModularProtocols
 import ICTMDBNetworkManagerKit


public class ICTMDBAllListModule : @preconcurrency AllListModuleProtocol {
 
    public init() { }
    
    @MainActor public func createAllListModule(type: AllListType) -> UIViewController {
        let viewController = AllListViewController()
        let router = AllListRouter()
        let interactor = AllListInteractor()
        
        let presenter : any ViewToPresenterAllListProtocol & InteractorToPresenterAllListProtocol
        = AllListPresenter(view: viewController, interactor: interactor, router: router)
        viewController.presenter = presenter
        interactor.presenter = presenter
        let listType:ListType = type == .popular ? .popular : .airingToday
        presenter.getAllList(at: listType)
        return viewController
    }
    
    
    
    static func mockCreateAllListModule() -> UIViewController {
        let viewController = AllListViewController()
        let router = AllListRouter()
        let interactor = AllListInteractor()
        
        let presenter : any ViewToPresenterAllListProtocol & InteractorToPresenterAllListProtocol
        = AllListPresenter(view: viewController, interactor: interactor, router: router)
        viewController.presenter = presenter
        interactor.presenter = presenter
     
        presenter.getAllList(at: .popular)
        return viewController
    }
}
