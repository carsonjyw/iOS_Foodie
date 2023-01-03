//
//  YelpModel.swift
//  Foodie
//
//  Created by Carson Wang on 12/6/22.
//

import Foundation

// MARK: - Businesses
struct YelpModel: Codable {
    let businesses: [Business]
    let region: Region?
    let total: Int?
}

// MARK: - Business
struct Business: Codable {
    let alias: String?
    let categories: [Category]?
    let coordinates: Center?
    let displayPhone: String?
    let distance: Double?
    let id: String?
    let imageURL: String?
    let isClosed: Bool?
    let location: Location?
    let name, phone, price: String?
    let rating, reviewCount: Double?
    let transactions: [String]?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case alias, categories, coordinates
        case displayPhone = "display_phone"
        case distance, id
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case location, name, phone, price, rating
        case reviewCount = "review_count"
        case transactions, url
    }
}

// MARK: - Category
struct Category: Codable {
    let alias, title: String?
}

// MARK: - Center
struct Center: Codable {
    let latitude, longitude: Double?
}

// MARK: - Location
struct Location: Codable {
    let address1, address2, address3, city: String?
    let country: String?
    let displayAddress: [String]?
    let state, zipCode: String?

    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city, country
        case displayAddress = "display_address"
        case state
        case zipCode = "zip_code"
    }
}

// MARK: - Region
struct Region: Codable {
    let center: Center?
}
