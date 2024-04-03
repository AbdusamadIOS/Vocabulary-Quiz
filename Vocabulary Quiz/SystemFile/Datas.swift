//
//  Datas.swift
//  Vocabulary Quiz
//
//  Created by Javlonbek on 28/03/24.
//

import Foundation

enum QuestionType: String, CaseIterable {
    case test = "test"
    case listening = "listening"
    case writing = "writing"
    case speaking = "speaking"
}

struct QuestionModel {
    var type: QuestionType
    var question: String
    var answer: String
    var answers: [String]?
}

struct Datas {
    static let list = BundleDatas().datahello()
}

class BundleDatas {
    func datahello() -> [QuestionModel] {
        guard let filepath = Bundle.main.path(forResource: "4eew1Quizzes", ofType: "csv") else {
            return []
        }
        var data = ""
        do {
            data = try String(contentsOfFile: filepath)
        } catch {
            print(error)
            return []
        }
        var result: [QuestionModel] = []
        let rows = data.components(separatedBy: "\r\n")
        for row in rows {
            let columns = row.components(separatedBy: ";")
            if columns.count == 6 {
                result.append(QuestionModel(type: QuestionType(rawValue: columns[0]) ?? .test, question: columns[1], answer: columns[2], answers: [columns[2],columns[3],columns[4],columns[5]]))
            } else if columns.count == 3 {
                result.append(QuestionModel(type: QuestionType(rawValue: columns[0]) ?? .test, question: columns[1], answer: columns[2]))
            }
        }
        return result
    }
}
