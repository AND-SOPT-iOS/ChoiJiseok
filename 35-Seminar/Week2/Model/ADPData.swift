//
//  ADPData.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import Foundation

// MARK: - ADPData
struct ADPData: Codable {
    let appTitleInfo: AppTitleInfo
    let appShortInfo: AppShortInfo
    let notice: Notice
    let previewImages: PreviewImages
    let compatibleDevices: CompatibleDevices
    let appDetailInfo: AppDetailInfo
    let developerInfo: DeveloperInfo
    let ratingAndReviews: RatingAndReviews
}

// MARK: - AppTitleInfo
struct AppTitleInfo: Codable {
    let appName: String
    let appDescription: String
}

// MARK: - AppShortInfo
struct AppShortInfo: Codable {
    let evaluation: Evaluation
    let awards: Awards
    let age: Age
    let chart: Chart
    let developer: Developer
    let language: Language
}

struct Evaluation: Codable {
    let totalReviews: Int
    let averageRating: Double
}

struct Awards: Codable {
    let awardImageUrl: String
}

struct Age: Codable {
    let minimumAgeTitle: Int
}

struct Chart: Codable {
    let ranking: Int
    let category: String
}

struct Developer: Codable {
    let developerIcon: String
    let developerName: String
}

struct Language: Codable {
    let languageCode: String
    let supportedLanguagesCount: Int
}

// MARK: - Notice
struct Notice: Codable {
    let version: String
    let elapsedDays: String
    let content: String
}

// MARK: - PreviewImages
struct PreviewImages: Codable {
    let images: [String]
}

// MARK: - CompatibleDevices
struct CompatibleDevices: Codable {
    let deviceIcons: [String]
    let deviceNames: [String]
}

// MARK: - AppDetailInfo
struct AppDetailInfo: Codable {
    let content: String
}

// MARK: - DeveloperInfo
struct DeveloperInfo: Codable {
    let developerName: String
}

// MARK: - RatingAndReviews
struct RatingAndReviews: Codable {
    let averageRating: Double
    let totalReviews: Int
    let mostHelpfulReviews: [MostHelpfulReview]
}

struct MostHelpfulReview: Codable {
    let title: String
    let userRating: Double
    let reviewDate: String
    let userName: String
    let content: String
}
