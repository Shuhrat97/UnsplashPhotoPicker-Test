//
//  FilterResponse.swift
//  UnsplashPhotoPicker-Test
//
//  Created by Shuhrat Nurov on 17/10/22.
//

import Foundation

struct FilterResponse:Codable{
    let total:Int
    let totalPages:Int
    let results:[Photo]
    
    enum CodingKeys: String, CodingKey {
        case total
        case results
        case totalPages = "total_pages"
    }
}
