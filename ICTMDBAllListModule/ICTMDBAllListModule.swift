//
//  ICTMDBAllListModule.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import Foundation
import SwiftUI

import ICTMDBNetworkManagerKit
import ICTMDBModularProtocols

public class ICTMDBAllListModule : @MainActor AllListModuleProtocol  {
    public init() { }
    @MainActor public func createAllListModule(type: ICTMDBModularProtocols.AllListType) -> AnyView {
        let viewModel = AllListViewModel(service: AllListService(networkManager: NetworkManager()))
        let listType:ListType = type == .popular ? .popular : .airingToday
        viewModel.loadData(type: listType)
        let view = AllListScreen(viewModel: viewModel)
        return AnyView(view)
    }
    
  
}
