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
    var answer: String
    var question0: String
    var question1: String?
    var question2: String?
    var question3: String?
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
                result.append(QuestionModel(type: QuestionType(rawValue: columns[0]) ?? .test, answer: columns[1], question0: columns[2], question1: columns[3], question2: columns[4], question3: columns[5]))
            } else if columns.count == 3 {
                result.append(QuestionModel(type: QuestionType(rawValue: columns[0]) ?? .test, answer: columns[1], question0: columns[2]))
            }
        }
        return result
    }
}
