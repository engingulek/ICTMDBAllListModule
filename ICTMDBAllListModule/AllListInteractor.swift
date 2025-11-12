//
//  AllListInteractor.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 12.11.2025.
//
 import ICTMDBNetworkManagerKit
import Foundation


final class AllListInteractor : @preconcurrency PresenterToInteractorAllListProtocol {
    var presenter: (any InteractorToPresenterAllListProtocol)?

    private let network : NetworkManagerProtocol
    init(network: NetworkManagerProtocol) {
       
        self.network = network
    }
    let deviceLanguageCode = Locale.current.language.languageCode ?? .english
    @MainActor func loadTvShows(type:ListType,page:Int) {
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
    }
    
}

