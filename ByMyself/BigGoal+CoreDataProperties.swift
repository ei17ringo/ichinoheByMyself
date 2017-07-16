//
//  BigGoal+CoreDataProperties.swift
//  ByMyself
//
//  Created by Eriko Ichinohe on 2017/07/16.
//  Copyright © 2017年 Eriko Ichinohe. All rights reserved.
//

import Foundation
import CoreData


extension BigGoal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BigGoal> {
        return NSFetchRequest<BigGoal>(entityName: "BigGoal")
    }

    @NSManaged public var saveDate: NSDate?
    @NSManaged public var time: String?
    @NSManaged public var title: String?

}
