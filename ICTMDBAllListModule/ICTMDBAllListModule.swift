//
//  ICTMDBAllListModule.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import Foundation
import SwiftUI

import ICTMDBNetworkManagerKit


public class ICTMDBAllListModule  {
 
    public init() { }
    
    @MainActor static func createModule(type:ListType) -> AnyView  {
        let viewModel = AllListViewModel(service: AllListService(networkManager: NetworkManager()))
        viewModel.loadData(type: type)
        let view = AllListScreen(viewModel: viewModel)
        return AnyView(view)
    }
    
  
}
