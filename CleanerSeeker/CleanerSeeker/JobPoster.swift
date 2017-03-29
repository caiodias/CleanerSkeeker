//
//  JobPoster.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

class JobPoster: User {
    // swiftlint:disable:next variable_name
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    var address: String
    var latitude: Double
    var longitude: Double
    var avatar: String

    init() {
        self.id = ""
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.address = ""
        self.latitude = 0.0
        self.longitude = 0.0
        self.avatar = ""
    }
}
