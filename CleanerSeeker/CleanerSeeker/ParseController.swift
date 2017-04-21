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
        case CantCreateFileFromData
        case UserIsNotLoggedIn
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
                if user.userType == CSUserType.Worker.rawValue {
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

    func updateProfileImage(image: Data, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {

        if let currentUser = CSUser.current() {

            if let imageFile = CSFile(name:"avatar.png", data:image) {
                currentUser.avatar = imageFile
                currentUser.saveInBackground(block: { (_, error) in
                    if let error = error {
                        onFail(error)
                    } else {
                        onSuccess(currentUser)
                    }
                })
            } else {
                onFail(ParseDbErrors.CantCreateFileFromData)
            }
        }
    }

    func getUserProfileImage(image: CSFile, onSuccess: @escaping ApiSuccessScenario, onFail:    @escaping ApiFailScenario) {
        image.getDataInBackground { (data, error) in

            if let data = data {
                onSuccess(data)
            } else {
                onFail(error!)
            }
        }
    }

    func updateCurrentUserLocation() {
        if let currentUser = CSUser.current() {
            PFGeoPoint.geoPointForCurrentLocation(inBackground: { (geoPoint, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    //get worker extra info
                    if currentUser.userType == CSUserType.Worker.rawValue {
                        self.getWorkerDetails(user: currentUser, onSuccess: { (worker) in

                            if let worker = worker as? Worker {
                                worker.location = geoPoint!
                                worker.saveEventually()
                            }

                        }, onFail: { (error) in
                            print(error.localizedDescription)
                        })
                    }
                }
            })

        }
    }

    func getWorkerDetails(user: CSUser, onSuccess: @escaping ApiSuccessScenario, onFail:    @escaping ApiFailScenario) {
        if let currentUser = CSUser.current() {
            let query = PFQuery(className: Worker.parseClassName())
            query.whereKey("userRelationId", equalTo: currentUser)
            query.getFirstObjectInBackground(block: { (worker, error) in
                if let worker = worker as? Worker {
                    onSuccess(worker)
                } else {
                    onFail(error!)
                }
            })
        }
    }

    func getJobPosterDetails(user: CSUser, onSuccess: @escaping ApiSuccessScenario, onFail:    @escaping ApiFailScenario) {
        if let currentUser = CSUser.current() {
            let query = PFQuery(className: JobPoster.parseClassName())
            query.whereKey("userRelationId", equalTo: currentUser)
            query.getFirstObjectInBackground(block: { (worker, error) in
                if let jobPoster = worker as? JobPoster {
                    onSuccess(jobPoster)
                } else {
                    onFail(error!)
                }
            })
        }

    }
}

// MARK: Post Flow Methods

extension ParseController {
    func registerJobOpportunity(job: JobOpportunity, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        print("Adding a new Job Opportunity")

        guard let currentUser = CSUser.current()  else {
            onFail(ParseDbErrors.UserIsNotLoggedIn)
            return
        }

        // Set the owner of job opportunity
        let relation = job.relation(forKey: "ownerId")
        relation.add(currentUser)

        job.status = JobStatus.active.rawValue // Active by default

        //Fetch and save location on success
        LocationController.getCordinatesByAddress(street: job.address, zipCode: job.zipcode, onSuccess: { location in

            let parseLocation = PFGeoPoint(latitude: location.latitude, longitude: location.longitude)
            job.location = parseLocation

            job.saveInBackground { (_, error: Error?) -> Void in
                if let error = error {
                    onFail(error)
                } else {
                    onSuccess(job) // now job has to have id
                }
            }

        }) { error in
            onFail(error)
        }

    }

    func getAllJobOpportunitiesInRange(user: CSUser, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {

        // Fetch Cleaner details (searchRadius, currentLocation)
        self.getWorkerDetails(user: user, onSuccess: { workerResponse in
            if let worker = workerResponse as? Worker {

                let query = PFQuery(className: "JobOpportunity")

                query.whereKey("status", equalTo:JobStatus.active.rawValue) // Active
                query.whereKey("location", nearGeoPoint: worker.location, withinKilometers: worker.searchRadius) // Filter by destination

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

        }, onFail: { (error) in
            print("Fail when fetching Cleaner \(error)")
        })
    }

    func getAllJobsOpportunitiesBy(ownerID: CSUser, jobStatus: JobStatus, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        let query = PFQuery(className: "JobOpportunity")

        query.whereKey("status", equalTo: jobStatus.rawValue) // Active
        query.whereKey("ownerId", equalTo: ownerID)

        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
            if let error = error {
                print("Error on fetch \(jobStatus) Job Opportunities")
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
