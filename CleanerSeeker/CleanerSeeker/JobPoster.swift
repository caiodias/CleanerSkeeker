//
//  JobPoster.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Parse

class JobPoster: PFObject, PFSubclassing {
    enum JobPosterErrors: Error {
        case JobNotFound
    }

    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var address: String
    @NSManaged var jobOpportunities: [JobOpportunity]

    class func parseClassName() -> String {
        return "JobPoster"
    }

    func getJobs(status: JobStatus) throws -> [JobOpportunity] {
        return self.jobOpportunities.filter({ $0.status == status.rawValue })
    }
}
