//
//  Deal.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Parse

class Deal: PFObject, PFSubclassing {
    @NSManaged var cleaner: CSUser
    @NSManaged var job: JobOpportunity
    @NSManaged var date: Date

    class func parseClassName() -> String {
        return "Deal"
    }

    init(cleaner: CSUser, job: JobOpportunity) {
        super.init()
        self.cleaner = cleaner
        self.job = job
        self.date = Date()
    }
}
