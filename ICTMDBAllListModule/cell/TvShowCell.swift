//
//  TvShowCell.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import UIKit
internal import SnapKit
internal import ICTMDBViewKit
final class TvShowCell: UICollectionViewCell {
    static let identifier = "TvShowCell"
  
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
      
        contentView.backgroundColor = .red
    }
    
    func configure() {
    
    }
}
