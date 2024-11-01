//
//  Models.swift
//  35-Seminar
//
//  Created by 최지석 on 11/1/24.
//

struct BannerSection: Codable, Hashable {
    let id: Int?
    let additionalText: String?
    let recommendType: String?
    let title: String?
    let description: String?
    let fullImageUrl: String?
    let appIconUrl: String?
    let subText: String?
    let inAppPurchaseExists: Bool?
}

struct EssentialSection: Codable, Hashable {
    let title: String?
    let description: String?
    let items: [EssentialItem]?
}

struct EssentialItem: Codable, Hashable {
    let id: Int?
    let imageUrl: String?
    let title: String?
    let description: String?
    let inAppPurchaseExists: Bool?
}

struct RankingSection: Codable, Hashable {
    let title: String?
    let description: String?
    let items: [RankingItem]?
}

struct RankingItem: Codable, Hashable {
    let id: Int?
    let ranking: Int?
    let imageUrl: String?
    let title: String?
    let description: String?
    let inAppPurchaseExists: Bool?
}

struct ALPData: Codable {
    let bannerSection: [BannerSection]?
    let essentialSection: EssentialSection?
    let paidRankingSection: RankingSection?
    let freeRankingSection: RankingSection?
}



struct PLPData: Codable {
    let paidRankingSection: PLPRankingSection?
    let freeRankingSection: PLPRankingSection?
}

struct PLPRankingSection: Codable, Hashable {
    let items: [PLPRankingItem]?
}

struct PLPRankingItem: Codable, Hashable {
    let id: Int?
    let ranking: Int?
    let imageUrl: String?
    let title: String?
    let description: String?
    let inAppPurchaseExists: Bool?
}
