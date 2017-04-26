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
    case applied
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
    @NSManaged var totalMinutesToWork: Int
    @NSManaged var ownerId: CSUser
    @NSManaged var appliedId: CSUser?
    @NSManaged var price: Double
    @NSManaged var jobWorkDate: Date
    @NSManaged var location: PFGeoPoint

    class func parseClassName() -> String {
        return "JobOpportunity"
    }

    static func calculatePrice(numberOfBeds: Int, numberOfWashs: Int, totalMinutesOfWork: Int) -> Double {
        let priceForWashrooms = Double(numberOfBeds * 5)
        let priceForBedrooms = Double(numberOfWashs * 3)
        let priceBasedOnTime = Double(totalMinutesOfWork) * 0.2
        let totalPrice = priceForBedrooms + priceForWashrooms + priceBasedOnTime

        return totalPrice
    }
}
