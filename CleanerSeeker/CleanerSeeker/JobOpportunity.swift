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
    case none = 0
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
    @NSManaged var ownerId: String
    @NSManaged var appliedId: String?
    @NSManaged var price: Double
    @NSManaged var jobWorkDate: Date

//    convenience init(address: String, zipcode: String, spaceType: JobSpaceType, ownerId: String, jobWorkDate: Date) {
//        self.init(spaceType: JobSpaceType.none, address: address, zipcode: zipcode, latitude: 0.0, longitude: 0.0, numberBedrooms: 1, numberWashrooms: 1, hoursToWork: 1, status: JobStatus.none, ownerId: ownerId, appliedId: nil, price: 0.0, jobWorkDate: jobWorkDate)
//    }
//
//    init(spaceType: JobSpaceType, address: String, zipcode: String, latitude: Double, longitude: Double, numberBedrooms: Int, numberWashrooms: Int, hoursToWork: Int, status: JobStatus, ownerId: String, appliedId: String?, price: Double, jobWorkDate: Date) {
//        self.spaceType = spaceType
//        self.address = address
//        self.zipcode = zipcode
//        self.latitude = latitude
//        self.longitude = longitude
//        self.numberBedrooms = numberBedrooms
//        self.numberWashrooms = numberWashrooms
//        self.hoursToWork = hoursToWork
//        self.status = status
//        self.ownerId = ownerId
//        self.appliedId = appliedId
//        self.price = price
//        self.jobWorkDate = jobWorkDate
//    }

    class func parseClassName() -> String {
        return "JobOpportunity"
    }
}
