//
//  PostData.swift
//  H4X0R
//
//  Created by Saurabh Kumar Verma on 20/07/2023.
//

import Foundation

struct PostData: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}
