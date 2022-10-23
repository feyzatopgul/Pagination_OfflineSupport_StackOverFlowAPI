//
//  QuestionsViewModel.swift
//  StackOverFlowQuestions
//
//  Created by fyz on 9/15/22.
//

import Foundation
import UIKit

class QuestionsViewModel {
    
    private let networkManager = NetworkManager.shared
    private let coreDataManager = CoreDataManager.shared
    var page = 1
    
    func fetchQuestions (completion: @escaping (_ questions:[Question]?, _ error: Error?) -> Void) {
        networkManager.fetchData(page: page) {[weak self] questions, error in
            guard let self = self else {return}
            if let error = error {
                DispatchQueue.main.async {
                    let offlineQuestions = self.coreDataManager.fetchQuestions()
                    if !offlineQuestions.isEmpty {
                        completion(offlineQuestions, nil)
                    } else {
                        completion(nil, error)
                    }
                }
            }
            if let questions = questions {
                if questions.isEmpty {
                    DispatchQueue.main.async {
                        let offlineQuestions = self.coreDataManager.fetchQuestions()
                        if !offlineQuestions.isEmpty {
                            completion(offlineQuestions, nil)
                        }
                    }
                } else {
                    completion(questions, nil)
                }
            }
        }
    }
}
