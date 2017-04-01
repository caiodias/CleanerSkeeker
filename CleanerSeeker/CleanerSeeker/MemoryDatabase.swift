//
//  MemoryDatabase.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

class MemoryDatabase {
    enum MemoryDbErrors: Error {
        case UserAlreadyExists
    }

    var users: [User]
    var jobs: [JobOpportunity]

    init() {
        self.users = []
        self.jobs = []
    }

    func addUser(user: User) throws {
        if self.users.contains(where: { userOnArray in userOnArray.email == user.email }) {
            throw MemoryDbErrors.UserAlreadyExists
        } else {
            self.users.append(user)
            print("Uew user \(user.email) added")
        }
    }

    func loginUser(login: String, password: String) -> User? {
        let user = self.users.first(where: { user in user.email == login })

        if user != nil {
            print("User \(login) logged")
        } else {
            print("User \(login) NOT logged")
        }

        return user
    }
}

// Jobs methods
extension MemoryDatabase {
    func addJob(job: JobOpportunity) {
        self.jobs.append(job)
    }
}
