//
//  DataResult.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 12.11.2025.
//

struct DataResult<T:Codable & Sendable>: Codable , Sendable {
    let page: Int
    let results: [T]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

