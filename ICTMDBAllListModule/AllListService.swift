//
//  AllListService.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 22.12.2025.
//
import Foundation
import ICTMDBNetworkManagerKit

protocol AllListServiceProtocol {
    func loadTvShows(
        type:ListType,
        page:Int,
        completion: @escaping (Result<DataResult<TvShow>, Error>) -> Void)
}


final class AllListService : AllListServiceProtocol {
   
    
    private let networkManager : NetworkManagerProtocol
    let deviceLanguageCode = Locale.current.language.languageCode ?? .english
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func loadTvShows(type: ListType, page: Int, completion: @escaping (Result<DataResult<TvShow>, any Error>) -> Void) {
        let request = TvShowRequest(
                   language: deviceLanguageCode == .turkish ? .tr : .en,
                   page: page,
                   allListType: type)
        
        networkManager.execute(request) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
 
    
    
}
