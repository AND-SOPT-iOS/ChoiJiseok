//
//  AppPreviewImageCollectionViewCell.swift
//  35-Seminar
//
//  Created by 최지석 on 10/29/24.
//

import UIKit
import SnapKit
import Then


final class AppPreviewImageCollectionViewCell: UICollectionViewCell {
    
    private let previewImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 24
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Week2ColorSet.borderGray.cgColor
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clearUI()
    }
    
    
    private func makeUI() {
        addSubview(previewImageView)
        previewImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    public func setUI(imageURL: String) {
        clearUI()
        
        previewImageView.image = UIImage(named: imageURL)
    }
    
    
    private func clearUI() {
        previewImageView.image = nil
    }
}
