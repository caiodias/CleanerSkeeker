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

extension PFUser {
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var userType: Int
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
}
