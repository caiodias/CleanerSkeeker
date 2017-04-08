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
        case DifferentObjectType
        case NilReturnObjects
    }

    var users: [PFUser]
    var jobs: [AnyObject]

    init() {
        self.users = []
        self.jobs = []
    }
}

// MARK: Login Flow Methods

extension ParseController {

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
                onSuccess(PFUser.current() as AnyObject)
            }
        }
    }
}

// MARK: Post Flow Methods

extension ParseController {
    func registerJobOpportunity(user: JobPoster, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        print("Adding a new Job Opportunity")

        user.saveInBackground { (_, error: Error?) -> Void in
            if let error = error {
                onFail(error)
            } else {
                onSuccess(PFUser.current() as AnyObject)
            }
        }
    }

    func getAllJobOpportunitiesInRange(user: Worker, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        let query = PFQuery(className:"JobOpportunity")
        query.whereKey("status", equalTo:"0")

        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
            if let error = error {
                print("Error on fetch active Job Opportunities")
                onFail(error)
            } else {
                // Do something with the found objects
                if let objects = objects {
                    print("Successfully retrieved \(objects.count) job opportunities.")

                    if objects is [JobOpportunity] {
                        onSuccess(objects as AnyObject)
                    } else {
                        print("objects are not the [JobOpportunity] type 😕")
                        onFail(ParseDbErrors.DifferentObjectType)
                    }
                } else {
                    print("Successfully but without objects")
                    onFail(ParseDbErrors.NilReturnObjects)
                }
            }
        }
    }
}
