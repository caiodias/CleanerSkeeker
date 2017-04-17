//
//  PFUser+Extension.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-04-05.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Parse

enum PFUserType: Int {
    case Worker = 0
    case JobPoster = 1
}

class CSUser: PFUser {
    @NSManaged var avatar: CSFile
    @NSManaged var userType: Int
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var phoneNumber: String
    @NSManaged var street: String
    @NSManaged var unit: String
    @NSManaged var city: String
    @NSManaged var postalCode: String
    @NSManaged var long: Double
    @NSManaged var lat: Double
}
