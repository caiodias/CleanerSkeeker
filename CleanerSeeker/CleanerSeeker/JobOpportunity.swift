//
//  Job.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Foundation
import Parse

enum JobSpaceType: Int {
    case none = -1
    case house
    case building
}

enum JobStatus: Int {
    case none = 0
    case active
    case done
    case hold
}

class JobOpportunity: PFObject, PFSubclassing {
    @NSManaged var spaceType: Int
    @NSManaged var status: Int
    @NSManaged var address: String
    @NSManaged var zipcode: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var numberBedrooms: Int
    @NSManaged var numberWashrooms: Int
    @NSManaged var hoursToWork: Int
    @NSManaged var ownerId: CSUser
    @NSManaged var appliedId: CSUser?
    @NSManaged var price: Double
    @NSManaged var jobWorkDate: Date

    class func parseClassName() -> String {
        return "JobOpportunity"
    }
}
