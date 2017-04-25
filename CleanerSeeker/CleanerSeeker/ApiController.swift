//
//  ApiController.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//
import Foundation
typealias ApiSuccessScenario = (Any) -> Void
typealias ApiFailScenario = (Error) -> Void

class ApiController {
    let parseDb: ParseController

    init() {
        self.parseDb = ParseController()
    }
}

// MARK: Login Flow Methods

extension ApiController {
    enum LoginFlowError: Error {
        case UserNotFound
        case UserAlreadyExists
    }

    func registerCSUser(user: CSUser, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.parseDb.addUser(user: user, onSuccess: onSuccess, onFail: onFail)
    }

    func loginUser(login: String, password: String, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        // TODO: Implement the call using Parse framework
        self.parseDb.loginUser(login: login, password: password, onSuccess: onSuccess, onFail: onFail)
    }

    //Reset user password using user email
    func resetPassword(email: String, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.parseDb.requestPasswordReset(forEmail: email, onSuccess: onSuccess, onFail: onFail)
    }

    func logout(onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.parseDb.logoutUser(onSuccess: onSuccess, onFail: onFail)
    }

    func updateUser(user: CSUser, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.parseDb.updateUser(user: user, onSuccess: onSuccess, onFail: onFail)
    }

    func updateUserAvatar(image: Data, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.parseDb.updateProfileImage(image: image, onSuccess: onSuccess, onFail: onFail)
    }

    func getUserProfileImage(image: CSFile, onSuccess: @escaping ApiSuccessScenario, onFail:    @escaping ApiFailScenario) {
        self.parseDb.getUserProfileImage(image: image, onSuccess: onSuccess, onFail: onFail)
    }

    func updateCurrentUserLocation() {
        self.parseDb.updateCurrentUserLocation()
    }

}

// MARK: Post Flow Methods

extension ApiController {
    enum PostFlowError: Error {
        case PostNotFound
        case NoPossibleToGetCurrentUser
        case NoPossibleToGetIdFromCurrentUser
    }

    func registerJobOpportunity(job: JobOpportunity, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        job.price = JobOpportunity.calculatePrice(numberOfBeds: job.numberBedrooms, numberOfWashs: job.numberWashrooms, totalMinutesOfWork: job.totalMinutesToWork)

        self.parseDb.registerJobOpportunity(job: job, onSuccess: onSuccess, onFail: onFail)
    }

    func getAllJobsOpportunitiesBy(jobStatus: JobStatus, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        guard let user = CSUser.current() else {
            print("Not possible to get the current user")
            onFail(PostFlowError.NoPossibleToGetCurrentUser)
            return
        }

        self.parseDb.getAllJobsOpportunitiesBy(ownerID: user, jobStatus: jobStatus, onSuccess: onSuccess, onFail: onFail)
    }
}

// MARK: Apply Flow Methods

extension ApiController {
    enum ApplyFlowError: Error {
        case None
    }

    func apply(to job: JobOpportunity, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        job.appliedId = CSUser.current() // attach worker
        self.parseDb.apply(to: job, onSuccess: onSuccess, onFail: onFail)
    }

    func getAllJobOpportunitiesInRange(onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        guard let currentUser = CSUser.current() else {
            print("Not possible to get current user")
            return
        }

        self.parseDb.getAllJobOpportunitiesInRange(for: currentUser, onSuccess: onSuccess, onFail: onFail)
    }

}
