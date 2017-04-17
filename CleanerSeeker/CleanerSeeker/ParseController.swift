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

    func addUser(user: CSUser, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        print("Adding a new User")

        //Finally signup the user
        user.signUpInBackground { (_, error: Error?) -> Void in
            if let error = error {
                onFail(error)
            } else {
                // Set Relation to Pseudo user object
                var customUser: PFObject
                if user.userType == PFUserType.Worker.rawValue {
                    customUser = Worker()
                } else {
                    customUser = JobPoster()
                }

                let relation = customUser.relation(forKey: "userRelationId")
                relation.add(user)

                //Save pseudo user object
                customUser.saveEventually { (_, error) in
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
        CSUser.requestPasswordResetForEmail(inBackground: email) { (success: Bool, error: Error?) in
            if let error = error {
                onFail(error)
            } else {
                onSuccess(success)
            }
        }
    }

    func loginUser(login: String, password: String, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        let parseUser = CSUser()
        parseUser.username = login
        parseUser.password = password

        CSUser.logInWithUsername(inBackground: login, password: password, block: { (user: PFUser?, error: Error?) -> Void in
            if let error = error {
                onFail(error)
            } else {

                guard let castedUser = user as? CSUser else {
                    onSuccess(user as Any)
                    return
                }

                onSuccess(castedUser)
            }
        })
    }

    func logoutUser(onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        CSUser.logOutInBackground { (error: Error?) in
            if let error = error {
                onFail(error)
            } else {
                onSuccess(CSUser.current() as Any)
            }
        }
    }

    func updateUser(user: CSUser, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        user.saveInBackground(block: { (success, error) in
            if let error = error {
                onFail(error)
            } else {
                onSuccess(success)
            }
        })
    }

}

// MARK: Post Flow Methods

extension ParseController {
    func registerJobOpportunity(job: JobOpportunity, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        print("Adding a new Job Opportunity")

        job.saveInBackground { (_, error: Error?) -> Void in
            if let error = error {
                onFail(error)
            } else {
                onSuccess(job) // now job has to have id
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

// MARK: Apply Flow Methods
extension ParseController {
    func apply(toJob: JobOpportunity, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        toJob.saveInBackground { (_, error: Error?) -> Void in
           if let error = error {
            print("Error on apply to Job Opportunity")
            onFail(error)
          } else {
            onSuccess(toJob) // has user relation
          }
        }
    }
}
