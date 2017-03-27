//
//  MemoryDatabase.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

class MemoryDatabase {
    private var _users: [User]
    private var _jobs: [JobOpportunity]

    init() {
        self._users = []
        self._jobs = []
    }

    func addUser(user: User) {
        self._users.append(user)
    }

    func addJob(job: JobOpportunity) {
        self._jobs.append(job)
    }

    func loginUser(login: String, password: String) -> Bool {
        var logged = false

        // TODO: Remove this stub implementation
        logged = !login.isEmpty && !password.isEmpty

        return logged
    }
}
