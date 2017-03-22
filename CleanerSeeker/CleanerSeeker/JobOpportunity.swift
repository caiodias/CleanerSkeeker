//
//  Job.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

class JobOpportunity {
    enum JobType {
        case clean
        case AnythingElse
    }

    let type: JobType
    var name: String

    convenience init(name: String) {
        self.init(type: JobType.clean, name: name)
    }

    init(type: JobType, name: String) {
        self.type = type
        self.name = name
    }
}
