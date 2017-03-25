//
//  Selector.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

class Worker: User {
    var id: Int
    var firstName: String
    var lastName: String
    var email: String
    var password: String

    init() {
        self.id = -1
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.password = ""
    }
}
