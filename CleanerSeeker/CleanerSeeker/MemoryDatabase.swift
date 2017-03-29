//
//  MemoryDatabase.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

class MemoryDatabase {
    var users: [User]
    var jobs: [JobOpportunity]

    init() {
        self.users = []
        self.jobs = []
    }

    func addUser(user: User) {
        self.users.append(user)
    }

    func loginUser(login: String, password: String) -> Bool {
        return self.users.contains(where: { user in user.email == login })
    }
}

// Jobs methods
extension MemoryDatabase {
    func addJob(job: JobOpportunity) {
        self.jobs.append(job)
    }
}
