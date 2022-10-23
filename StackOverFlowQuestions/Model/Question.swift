//
//  Question.swift
//  StackOverFlowQuestions
//
//  Created by fyz on 9/15/22.
//

import Foundation

public struct Questions: Codable {
    var items: [Question]
}

public struct Question: Codable {
    var tags: [String]
    var owner: Owner?
    var date:Int
    var title: String
    var isAnswered: Bool
    var viewCount: Int
    var answerCount:Int
}


public struct Owner: Codable {
    var name: String?
    var imageUrl: String
    var image: Data?
}

extension Question {
    enum CodingKeys: String, CodingKey {
        case tags
        case owner
        case date = "creation_date"
        case title
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case answerCount = "answer_count"
    }
}

extension Owner {
    enum CodingKeys: String, CodingKey {
        case name = "display_name"
        case imageUrl = "profile_image"
        case image
    }
}
