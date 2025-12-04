//
//  AllListViewController.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 12.11.2025.
//


import Foundation
import UIKit
 import GenericCollectionViewKit
 import ICTMDBViewKit
 import SnapKit

final class AllListViewController: UIViewController {

    // MARK: - Properties
    var presenter: (any ViewToPresenterAllListProtocol)?

    private lazy var layoutProvider: GenericCollectionLayoutProvider<AllListPresenter>? = {
        guard let presenter = presenter as? AllListPresenter else { return nil }
        return GenericCollectionLayoutProvider(source: presenter)
    }()

    private lazy var collectionView: UICollectionView = {
        guard let layoutProvider = layoutProvider else {
            let fallbackLayout = UICollectionViewFlowLayout()
            return UICollectionView(frame: .zero, collectionViewLayout: fallbackLayout)
        }

        let layout = layoutProvider.createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.register(TvShowCell.self,
                                forCellWithReuseIdentifier: TvShowCell.identifier)
        collectionView.register(CHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: String(describing: CHeaderView.self))
        return collectionView
    }()

    private lazy var dataSource: GenericCollectionDataSource<AllListPresenter>? = {
        guard let presenter = presenter as? AllListPresenter else { return nil }
        return GenericCollectionDataSource(source: presenter) { identifier, cell, item in
            guard let item = item as? TVShowPresentation else { return }
            (cell as? TvShowCell)?.configure(with: item)
        }
    }()

    private lazy var delegateSource: GenericCollectionDelegate<AllListPresenter>? = {
        guard let presenter = presenter as? AllListPresenter else { return nil }
        return GenericCollectionDelegate(source: presenter)
    }()

    private let label = UILabel()
    private let activityIndicator = UIActivityIndicatorView.baseActivityIndicator()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        presenter?.viewDidLoad()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(label)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.isHidden = true
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }

        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        collectionView.dataSource = dataSource
        collectionView.delegate = delegateSource
    }
}

// MARK: - PresenterToViewAllListProtocol
extension AllListViewController:  @MainActor PresenterToViewAllListProtocol {

    func prepareCollectionView() {

        collectionView.dataSource = dataSource
        collectionView.delegate = delegateSource
        collectionView.reloadData()
    }

    func startLoading() {
        activityIndicator.startAnimating()
    }

    func finishLoading() {
        activityIndicator.stopAnimating()
    }

    func relaodCollectionView() {
        collectionView.reloadData()
    }

    func sendErrorState(state: (isHidden: Bool, message: String)) {
        collectionView.isHidden = state.isHidden
        label.text = state.message
        label.isHidden = !state.isHidden
    }
}

#Preview {
  
    UINavigationController(rootViewController: ICTMDBAllListModule.mockCreateAllListModule())
}




