//
//  QuestionItem+CoreDataProperties.swift
//  StackOverFlowQuestions
//
//  Created by fyz on 9/20/22.
//
//

import Foundation
import CoreData


extension QuestionItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionItem> {
        return NSFetchRequest<QuestionItem>(entityName: "QuestionItem")
    }

    @NSManaged public var answerCount: Int32
    @NSManaged public var date: Int32
    @NSManaged public var isAnswered: Bool
    @NSManaged public var tags: [String]?
    @NSManaged public var title: String?
    @NSManaged public var viewCount: Int32
    @NSManaged public var owner: OwnerItem?

}

extension QuestionItem : Identifiable {

}
