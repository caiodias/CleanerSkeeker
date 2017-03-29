//
//  User.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

protocol User {
    // swiftlint:disable:next variable_name
    var id: String { get set }
    var firstName: String { get set }
    var lastName: String { get set }
    var address: String { get set }
    var latitude: Double { get set }
    var longitude: Double { get set }
    var email: String { get set }
    var avatar: String { get set }
}
