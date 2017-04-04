//
//  Selector.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Parse

enum CSUserType: Int {
    case None
    case Worker
    case JobPoster
}

class CSUser: PFUser {
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var address: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var avatar: String
    @NSManaged var userType: Int
    @NSManaged var jobOpportunities: [JobOpportunity]

    private convenience override init() {
        // do nothing. This should not be used
        self.init(userType: CSUserType.None)
    }

    convenience init(userType: CSUserType) {
        self.init(userType: userType, objectId: nil, firstName: "", lastName: "", email: nil, address: "", latitude: 0.0, longitude: 0.0, avatar: "")
    }

    convenience init(userType: CSUserType, firstName: String, lastName: String, email: String) {
        self.init(userType: userType, objectId: nil, firstName: firstName, lastName: lastName, email: email, address: "", latitude: 0.0, longitude: 0.0, avatar: "")
    }

    init(userType: CSUserType, objectId: String?, firstName: String, lastName: String, email: String?, address: String, latitude: Double, longitude: Double, avatar: String) {
        super.init()

        self.userType = userType.rawValue
        self.objectId = objectId
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.avatar = avatar

        if let email = email {
            self.email = email.lowercased()
            self.username = self.email
        }
    }

    // MARK: User Protocol methods
    func clone() -> CSUser {
        return CSUser(userType: CSUserType(rawValue: self.userType)!, objectId: self.objectId, firstName: self.firstName, lastName: self.lastName, email: self.email, address: self.address, latitude: self.latitude, longitude: self.longitude, avatar: self.avatar)
    }
}
