//
//  TabBarPage.swift
//  35-Seminar
//
//  Created by 최지석 on 11/7/24.
//

import Foundation

enum TabBarPage: String, CaseIterable {
    
    case today
    case game
    case app
    case arcade
    case server

    /// Index를 받아 매칭되는 case로 반환
    init?(index: Int) {
        switch index {
        case 0: self = .today
        case 1: self = .game
        case 2: self = .app
        case 3: self = .arcade
        case 4: self = .server
        default: return nil
        }
    }
    
    /// TabBarPage 형을 매칭되는 Int형으로 반환
    func pageIndex() -> Int {
        switch self {
        case .today: return 0
        case .game: return 1
        case .app: return 2
        case .arcade: return 3
        case .server: return 4
        }
    }
    
    /// TabBarPage 형을 매칭되는 한글명으로 변환
    func pageName() -> String {
        switch self {
        case .today: return "투데이"
        case .game: return "게임"
        case .app: return "앱"
        case .arcade: return "Arcade"
        case .server: return "서버"
        }
    }
    
    /// TabBarPage 형을 매칭되는 아이콘명으로 변환
    func iconName() -> String {
        switch self {
        case .today: return "doc.text.image"
        case .game: return "gamecontroller"
        case .app: return "square.stack.3d.up.fill"
        case .arcade: return "arcade.stick.console"
        case .server: return "server.rack"
        }
    }
}

