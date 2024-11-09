//
//  UITextField+Extension.swift
//  35-Seminar
//
//  Created by 최지석 on 11/9/24.
//

import UIKit

extension UITextField {
    func configureDefaultSettings() {
        autocorrectionType = .no           // 자동 수정 비활성화
        spellCheckingType = .no            // 맞춤법 검사 비활성화
        autocapitalizationType = .none     // 자동 대문자 비활성화
        clearButtonMode = .always          // 입력내용 한번에 지우는 x버튼(오른쪽)
        clearsOnBeginEditing = false       // 편집 시 기존 텍스트필드값 초기화 안되게끔
    }
    
    // 입력 테스트 왼쪽 inset 세팅
    func setLeftInset(_ inset: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: inset, height: frame.height))
        leftView = paddingView
        leftViewMode = ViewMode.always
    }
}
