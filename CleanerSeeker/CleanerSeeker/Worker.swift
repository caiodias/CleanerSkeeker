//
//  Selector.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Parse

class Worker: PFObject, PFSubclassing {
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var address: String

    /*convenience override init() {
        self.init(firstName: "", lastName: "", address: "", latitude: 0.0, longitude: 0.0, avatar: "")
    }

    convenience init(firstName: String, lastName: String) {
        self.init(firstName: firstName, lastName: lastName, address: "", latitude: 0.0, longitude: 0.0, avatar: "")
    }

    init(firstName: String, lastName: String, address: String, latitude: Double, longitude: Double, avatar: String) {
        super.init()

        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.avatar = avatar

    }

    // MARK: User Protocol methods
    func clone() -> Worker {
        return Worker(firstName: self.firstName, lastName: self.lastName, address: self.address, latitude: self.latitude, longitude: self.longitude, avatar: self.avatar)
    }*/

    // MARK: PFSubclassing Protocol methods

    static func parseClassName() -> String {
        return "Worker" //previous solution didn't work set the static
    }
}
