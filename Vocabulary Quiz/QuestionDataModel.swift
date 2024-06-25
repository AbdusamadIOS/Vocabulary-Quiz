//
//  QuestionDataModel.swift
//  Vocabulary Quiz
//
//  Created by Abdusamad Mamasoliyev on 22/05/24.
//

import Foundation

struct QuestionDataModel {
    let title: String
}

struct ResultDataModel: Codable {
    var question: String
    var answer: String
    var time: String
    var date: String
}
