//
//  AllListInteractor.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 12.11.2025.
//
 import ICTMDBNetworkManagerKit
import Foundation


final class AllListInteractor : PresenterToInteractorAllListProtocol,@unchecked Sendable {
   
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
            await MainActor.run {
                presenter?.sendData(result)
            }
    
        }catch{
           await MainActor.run {
               presenter?.sendError()
           }
            
          
        }
    }
}

