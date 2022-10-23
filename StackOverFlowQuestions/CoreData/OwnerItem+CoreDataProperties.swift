//
//  OwnerItem+CoreDataProperties.swift
//  StackOverFlowQuestions
//
//  Created by fyz on 9/20/22.
//
//

import Foundation
import CoreData


extension OwnerItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OwnerItem> {
        return NSFetchRequest<OwnerItem>(entityName: "OwnerItem")
    }

    @NSManaged public var image: Data?
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var question: NSSet?

}

// MARK: Generated accessors for question
extension OwnerItem {

    @objc(addQuestionObject:)
    @NSManaged public func addToQuestion(_ value: QuestionItem)

    @objc(removeQuestionObject:)
    @NSManaged public func removeFromQuestion(_ value: QuestionItem)

    @objc(addQuestion:)
    @NSManaged public func addToQuestion(_ values: NSSet)

    @objc(removeQuestion:)
    @NSManaged public func removeFromQuestion(_ values: NSSet)

}

extension OwnerItem : Identifiable {

}
