//
//  Selector.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

class Worker: User {
    // swiftlint:disable:next variable_name
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    var address: String
    var latitude: Double
    var longitude: Double
    var avatar: String

    convenience init() {
        self.init(id: "", firstName: "", lastName: "", email: "", address: "", latitude: 0.0, longitude: 0.0, avatar: "")
    }

    convenience init(firstName: String, lastName: String, email: String) {
        self.init(id: "", firstName: firstName, lastName: lastName, email: email, address: "", latitude: 0.0, longitude: 0.0, avatar: "")
    }

    init(id: String, firstName: String, lastName: String, email: String, address: String, latitude: Double, longitude: Double, avatar: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.avatar = avatar
    }

    func copy() -> User {
        return Worker(id: self.id, firstName: self.firstName, lastName: self.lastName, email: self.email, address: self.address, latitude: self.latitude, longitude: self.longitude, avatar: self.avatar)
    }
}
