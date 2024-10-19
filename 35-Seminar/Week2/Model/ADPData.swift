//
//  ADPData.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import Foundation

// MARK: - ADPData
struct ADPData: Codable {
    let appTitleInfo: AppTitleInfo?
    let appShortInfo: AppShortInfo?
    let appUpdates: AppUpdates?
    let previewImages: PreviewImages?
    let compatibleDevices: CompatibleDevices?
    let appDetailInfo: AppDetailInfo?
    let developerInfo: DeveloperInfo?
    let ratingAndReviews: RatingAndReviews?
}

// MARK: - AppTitleInfo
struct AppTitleInfo: Codable {
    let appName: String?
    let appDescription: String?
}

// MARK: - AppShortInfo
struct AppShortInfo: Codable {
    let evaluation: AppEvaluation?
    let awards: AppAwards?
    let age: AppAge?
    let chart: AppChart?
    let developer: AppDeveloper?
    let language: AppLanguage?
}

struct AppEvaluation: Codable {
    let totalReviews: Int?
    let averageRating: Double?
    let maxRating: Double?
}

struct AppAwards: Codable {
    let awardImageUrl: String?
}

struct AppAge: Codable {
    let minAge: Int?
}

struct AppChart: Codable {
    let ranking: Int?
    let category: String?
}

struct AppDeveloper: Codable {
    let developerIcon: String?
    let developerName: String?
}

struct AppLanguage: Codable {
    let languageCode: String?
    let supportedLanguagesCount: Int?
}

// MARK: - AppUpdates
struct AppUpdates: Codable {
    let version: String?
    let elapsedDays: String?
    let content: String?
}

// MARK: - PreviewImages
struct PreviewImages: Codable {
    let images: [String]?
}

// MARK: - CompatibleDevices
struct CompatibleDevices: Codable {
    let deviceIcons: [String]?
    let deviceNames: [String]?
}

// MARK: - AppDetailInfo
struct AppDetailInfo: Codable {
    let content: String?
}

// MARK: - DeveloperInfo
struct DeveloperInfo: Codable {
    let developerName: String?
}

// MARK: - RatingAndReviews
struct RatingAndReviews: Codable {
    let averageRating: Double?
    let totalReviews: Int?
    let mostHelpfulReviews: [MostHelpfulReview]?
}

struct MostHelpfulReview: Codable {
    let title: String?
    let userRating: Double?
    let maxRating: Double?
    let reviewDate: String?
    let userName: String?
    let content: String?
}
