//
//  MemoryDatabase.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

class MemoryDatabase {
    private let _users: [User]
    private let _jobs: [Job]

    init() {
        self._users = []
        self._jobs = []
    }
}
