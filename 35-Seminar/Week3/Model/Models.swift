//
//  Models.swift
//  35-Seminar
//
//  Created by 최지석 on 11/1/24.
//

struct BannerSection: Codable {
    let additionalText: String?
    let recommendType: String?
    let title: String?
    let description: String?
    let fullImageUrl: String?
    let appIconUrl: String?
    let subText: String?
    let inAppPurchaseExists: Bool?
}

struct EssentialSection: Codable {
    let title: String?
    let description: String?
    let items: [EssentialItem]?
}

struct EssentialItem: Codable {
    let imageUrl: String?
    let title: String?
    let description: String?
    let inAppPurchaseExists: Bool?
}

struct RankingSection: Codable {
    let title: String?
    let description: String?
    let items: [RankingItem]?
}

struct RankingItem: Codable {
    let imageUrl: String?
    let title: String?
    let description: String?
    let inAppPurchaseExists: Bool?
    let ranking: Int?
}

struct ALPData: Codable {
    let bannerSection: [BannerSection]?
    let essentialSection: EssentialSection?
    let paidRankingSection: RankingSection?
    let freeRankingSection: RankingSection?
}

