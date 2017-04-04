//
//  Job.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Parse

class JobOpportunity: PFObject {
    enum JobSpaceType: Int {
        case none
        case house
        case building
    }

    enum JobStatus: Int {
        case none
        case active
        case done
        case hold
    }

    var spaceType: JobSpaceType
    var address: String
    var zipcode: String
    var latitude: Double
    var longitude: Double
    var numberBedrooms: Int
    var numberWashrooms: Int
    var hoursToWork: Int
    var status: JobStatus
    var ownerId: String
    var appliedId: String?
    var price: Double
    var jobWorkDate: Date

    convenience init(address: String, zipcode: String, spaceType: JobSpaceType, ownerId: String, jobWorkDate: Date) {
        self.init(spaceType: JobSpaceType.none, address: address, zipcode: zipcode, latitude: 0.0, longitude: 0.0, numberBedrooms: 1, numberWashrooms: 1, hoursToWork: 1, status: JobStatus.none, ownerId: ownerId, appliedId: nil, price: 0.0, jobWorkDate: jobWorkDate)
    }

    init(spaceType: JobSpaceType, address: String, zipcode: String, latitude: Double, longitude: Double, numberBedrooms: Int, numberWashrooms: Int, hoursToWork: Int, status: JobStatus, ownerId: String, appliedId: String?, price: Double, jobWorkDate: Date) {
        self.spaceType = spaceType
        self.address = address
        self.zipcode = zipcode
        self.latitude = latitude
        self.longitude = longitude
        self.numberBedrooms = numberBedrooms
        self.numberWashrooms = numberWashrooms
        self.hoursToWork = hoursToWork
        self.status = status
        self.ownerId = ownerId
        self.appliedId = appliedId
        self.price = price
        self.jobWorkDate = jobWorkDate

        super.init()
    }
}
