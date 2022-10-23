//
//  CoreDataManager.swift
//  StackOverFlowQuestions
//
//  Created by fyz on 9/19/22.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchQuestions() -> [Question] {
        var questionItems = [QuestionItem]()
        var questions = [Question]()
        do {
            questionItems = try context.fetch(QuestionItem.fetchRequest())
            questionItems.forEach { questionItem in
                let owner = Owner(
                    name: questionItem.owner?.name,
                    imageUrl: questionItem.owner?.imageUrl ?? "",
                    image: questionItem.owner?.image)
                
                let question = Question(
                    tags: questionItem.tags ?? [],
                    owner: owner,
                    date: Int(questionItem.date),
                    title: questionItem.title ?? "",
                    isAnswered: questionItem.isAnswered,
                    viewCount: Int(questionItem.viewCount),
                    answerCount: Int(questionItem.answerCount))
                questions.append(question)
            }
            
        } catch {
            print(error)
        }
        return questions
    }
    func saveQuestions(questions:[Question]) {
        
        questions.forEach { question in
            let questionItem = QuestionItem(context: context)
            let ownerItem = OwnerItem(context: context)
            
            questionItem.title = question.title
            questionItem.tags = question.tags
            questionItem.date = Int32(question.date)
            questionItem.viewCount = Int32(question.viewCount)
            questionItem.answerCount = Int32(question.answerCount)
            
            ownerItem.name = question.owner?.name
            ownerItem.imageUrl = question.owner?.imageUrl
            if let url = question.owner?.imageUrl {
                ImageLoader.shared.loadImage(urlString: url) { image in
                    ownerItem.image = image.pngData()
                }
            }
            questionItem.owner = ownerItem
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
        
    }
}
