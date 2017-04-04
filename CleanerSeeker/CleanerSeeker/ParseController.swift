//
//  ParseController.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-04-01.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Parse

class ParseController {
//    enum MemoryDbErrors: Error {
//        case UserAlreadyExists
//    }

    var users: [PFUser]
    var jobs: [AnyObject]

    init() {
        self.users = []
        self.jobs = []

    }

    func addUser(user: User, password: String, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        let parseUser = PFUser()
        print("Addind a new User")

        parseUser.email = user.email
        parseUser.password = password
        parseUser.username = user.email
        parseUser["firstName"] = user.firstName
        parseUser["lastName"] = user.lastName
        parseUser["address"] = user.address
        parseUser["zipcode"] = ""
        parseUser["province"] = ""
        parseUser["country"] = ""
        parseUser["latitude"] = user.latitude
        parseUser["longitude"] = user.longitude
        parseUser["avatar"] = user.avatar

        parseUser.signUpInBackground { (_, error: Error?) -> Void in
            if let error = error {
                onFail(error)
            } else {
                if parseUser.objectId != nil {
                    print("user with ID")
                    var newUser = user.copy()
                    newUser.id = parseUser.objectId!

                    onSuccess(newUser as AnyObject)
                } else {
                    print("user without ID")

                    onSuccess(user as AnyObject)
                }
            }
        }
    }
}
