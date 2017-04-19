//
//  Selector.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Parse

class Worker: PFObject, PFSubclassing {
    @NSManaged var searchRadius: Double
    @NSManaged var userRelationId: PFUser
    @NSManaged var location: PFGeoPoint
    // MARK: PFSubclassing Protocol methods

    static func parseClassName() -> String {
        return "Worker" //previous solution didn't work set the static
    }
}
