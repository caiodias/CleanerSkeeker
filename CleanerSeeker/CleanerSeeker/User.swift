//
//  User.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

protocol User {
    var id: Int { get set }
    var firstName: String { get set }
    var lastName: String { get set }
    var email: String { get set }
    var password: String { get set }
}
