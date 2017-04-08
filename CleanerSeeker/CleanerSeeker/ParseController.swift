//
//  ParseController.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-04-01.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Parse

class ParseController {
    enum ParseDbErrors: Error {
        case UserWithoutType
        case UserNotFound
    }

    var users: [PFUser]
    var jobs: [AnyObject]

    init() {
        self.users = []
        self.jobs = []

    }

    func addUser(user: PFObject, password: String, email: String, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        print("Adding a new User")
        let pfUser = PFUser()
        pfUser.userType = user is Worker ? PFUserType.Worker.rawValue : PFUserType.JobPoster.rawValue
        pfUser.username = email
        pfUser.password = password
        pfUser.email = email

        //Finally signup the user
        pfUser.signUpInBackground { (_, error: Error?) -> Void in
            if let error = error {
                onFail(error)
            } else {
                // Set Relation to Pseudo user object
                let relation = user.relation(forKey: "userRelationId")
                relation.add(pfUser)

                //Save pseudo user object
                user.saveEventually { (_, error) in
                    if let error = error {
                        onFail(error)
                    } else {
                        onSuccess(user as AnyObject)
                    }
                }
            }
        }

    }

    /*func addUser(user: JobPoster, password: String, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        print("Adding a new Job Poster user")
        
        user.signUpInBackground { (_, error: Error?) -> Void in
            if let error = error {
                onFail(error)
            } else {
                onSuccess(user as AnyObject)
            }
        }
    }*/

    func requestPasswordReset(forEmail email: String, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        print("Request reset password by email")
        PFUser.requestPasswordResetForEmail(inBackground: email) { (success: Bool, error: Error?) in
            if let error = error {
                onFail(error)
            } else {
                onSuccess(success)
            }
        }
    }

    func loginUser(login: String, password: String, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        let parseUser = PFUser()
        parseUser.username = login
        parseUser.password = password

        PFUser.logInWithUsername(inBackground: login, password: password, block: { (user: PFUser?, error: Error?) -> Void in
            if let error = error {
                onFail(error)
            } else {
//                guard let parseUser = PFUser.current() else {
//                    onFail(ParseDbErrors.UserNotFound)
//                    return
//                }
//                
//                guard let userType = parseUser["userType"] as? Int else {
//                    onFail(ParseDbErrors.UserWithoutType)
//                    return
//                }

                onSuccess(user as AnyObject)
            }
        })
    }

    // MARK: Private Methods
//    private func fillPFUserObject(user: User) -> PFUser {
//        var returnObject = PFUser()
//    }

    func logoutUser(onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        PFUser.logOutInBackground { (error: Error?) in
            if let error = error {
                onFail(error)
            } else {
                onSuccess(PFUser.current() as Any)
            }
        }
    }
}
