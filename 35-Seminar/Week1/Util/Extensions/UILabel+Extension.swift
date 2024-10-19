//
//  UILabel+Extension.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit

extension UILabel {

    /// UILabel의 attributedText가 N줄 이상인지 확인하는 메서드
    /// - Parameter n: 확인할 줄 수
    /// - Returns: 텍스트가 N줄 이상인지 여부를 반환
    func isTextMoreThanLines(_ n: Int) -> Bool {
        // lineHeight 계산
        guard let font = self.font else { return false }
        let lineHeight = font.lineHeight
        
        // attributedText가 렌더링될 때 필요한 전체 크기 계산
        let textSize = CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude)
        
        guard let attributedText = self.attributedText else { return false }
        
        let textBoundingRect = attributedText.boundingRect(
            with: textSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )
        
        // 전체 텍스트의 높이를 lineHeight로 나누어 몇 줄인지 계산
        let numberOfLines = Int(ceil(textBoundingRect.height / lineHeight))
        
        // N줄을 초과하는지 여부 반환
        return numberOfLines > n
    }
}
