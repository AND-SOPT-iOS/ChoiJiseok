//
//  PlainCell.swift
//  35-Seminar
//
//  Created by 최지석 on 11/8/24.
//

import UIKit
import Then
import SnapKit

class PlainTableViewCell: UITableViewCell {
    
    private let rightArrowIconImageView = UIImageView().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        $0.image = UIImage(systemName: "chevron.right", withConfiguration: imageConfig)
        $0.tintColor = .lightGray
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        contentView.addSubview(rightArrowIconImageView)
        
        rightArrowIconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
    }
    
    
    public func setUI(title: String,
                      titleColor: UIColor,
                      shouldShowArrowIcon: Bool) {
        
        var config = UIListContentConfiguration.cell()
        config.attributedText = .makeAttributedString(text: title,
                                                      color: titleColor,
                                                      font: .systemFont(ofSize: 18, weight: .regular))
    
        contentConfiguration = config
        
        rightArrowIconImageView.isHidden = !shouldShowArrowIcon
    }
    
    
    private func clearUI() {
        contentConfiguration = nil
        rightArrowIconImageView.isHidden = true
    }
}

