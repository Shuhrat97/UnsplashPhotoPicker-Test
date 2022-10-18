//
//  Photo.swift
//  UnsplashPhotoPicker-Test
//
//  Created by Shuhrat Nurov on 17/10/22.
//

import Foundation

// MARK: - Photo
struct Photo: Codable {
    let id: String
    let createdAt, updatedAt: String
    let width, height: Int
    let color, blurHash: String
    let likes: Int
    let likedByUser: Bool
    let photoDescription: String?
    let user: User
    let currentUserCollections: [CurrentUserCollection]
    let urls: Urls
    let links: PhotoLinks

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width, height, color
        case blurHash = "blur_hash"
        case likes
        case likedByUser = "liked_by_user"
        case photoDescription = "description"
        case user
        case currentUserCollections = "current_user_collections"
        case urls, links
    }
}

// MARK: - CurrentUserCollection
struct CurrentUserCollection: Codable {
    let id: Int
    let title: String
    let publishedAt, lastCollectedAt, updatedAt: Date
    let coverPhoto, user: User?

    enum CodingKeys: String, CodingKey {
        case id, title
        case publishedAt = "published_at"
        case lastCollectedAt = "last_collected_at"
        case updatedAt = "updated_at"
        case coverPhoto = "cover_photo"
        case user
    }
}

// MARK: - PhotoLinks
struct PhotoLinks: Codable {
    let linksSelf, html, download, downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}

// MARK: - User
struct User: Codable {
    let id, username, name: String
    let portfolioURL: String?
    let bio:String?
    let location: String?
    let totalLikes, totalPhotos, totalCollections: Int
    let instagramUsername, twitterUsername: String?
    let profileImage: ProfileImage
    let links: UserLinks

    enum CodingKeys: String, CodingKey {
        case id, username, name
        case portfolioURL = "portfolio_url"
        case bio, location
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalCollections = "total_collections"
        case instagramUsername = "instagram_username"
        case twitterUsername = "twitter_username"
        case profileImage = "profile_image"
        case links
    }
}

// MARK: - UserLinks
struct UserLinks: Codable {
    let linksSelf, html, photos, likes: String
    let portfolio: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, medium, large: String
}
