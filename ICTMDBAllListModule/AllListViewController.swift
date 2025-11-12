//
//  AllListViewController.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 12.11.2025.
//


import Foundation
import UIKit
internal import GenericCollectionViewKit
internal import ICTMDBViewKit
internal import SnapKit

final class AllListViewController: UIViewController {

    // MARK: - Properties
    var presenter: (any ViewToPresenterAllListProtocol)?


 

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

}

// MARK: - PresenterToViewAllListProtocol
extension AllListViewController: @preconcurrency PresenterToViewAllListProtocol {

    func prepareCollectionView() {

    }

    func startLoading() {
  
    }

    func finishLoading() {
      
    }

    func relaodCollectionView() {
        
    }

    func sendErrorState(state: (isHidden: Bool, message: String)) {
       
    }
}


