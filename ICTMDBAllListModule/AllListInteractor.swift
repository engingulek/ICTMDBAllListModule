//
//  AllListInteractor.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 12.11.2025.
//
 import ICTMDBNetworkManagerKit
import Foundation


final class AllListInteractor : PresenterToInteractorAllListProtocol {
   
    weak var presenter: (any InteractorToPresenterAllListProtocol)?


    private let network : NetworkManagerProtocol
    init(network: NetworkManagerProtocol) {
       
        self.network = network
    }
    let deviceLanguageCode = Locale.current.language.languageCode ?? .english
    
    func loadTvShows(type: ListType, page: Int) async {
        let request = TvShowRequest(
            language: deviceLanguageCode == .turkish ? .tr : .en,
            page: page,
            allListType: type)
        
        
        do {
            let result = try await network.execute(request)
            presenter?.sendData(result)
        }catch{
            presenter?.sendError()
        }
    }
    
    /*@MainActor func loadTvShows(type:ListType,page:Int) {
        let request = TvShowRequest(
            language: deviceLanguageCode == .turkish ? .tr : .en,
            page: page,
            allListType: type)
        network.execute(request) {[weak self] result in
            guard let self else {return}
            switch result {
            case .success(let result):
                presenter?.sendData(result)
            case .failure:
                presenter?.sendError()
            }
        }
    }*/
    
}

