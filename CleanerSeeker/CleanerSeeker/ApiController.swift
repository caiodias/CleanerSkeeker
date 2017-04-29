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

    func getCurrentUser() -> CSUser {
        guard let currentUser = CSUser.current() else {
            print("Not possible to get current user")
            return CSUser()
        }

        return currentUser
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

    func getCurrentUserDetails(onSuccess: @escaping ApiSuccessScenario, onFail:    @escaping ApiFailScenario) {
        let user = getCurrentUser()

        if user.userType == CSUserType.Worker.rawValue {
            self.parseDb.getWorkerDetails(user: user, onSuccess: onSuccess, onFail: onFail)
        } else if user.userType == CSUserType.JobPoster.rawValue {
            self.parseDb.getJobPosterDetails(user: user, onSuccess: onSuccess, onFail: onFail)
        }
    }

    func updateCurrentUserLocation() {
        self.parseDb.updateCurrentUserLocation()
    }

    func saveUserDetails(userDetails: Worker, onSuccess: @escaping ApiSuccessScenario, onFail:    @escaping ApiFailScenario ) {
        self.parseDb.saveCSObject(object: userDetails, onSuccess: onSuccess, onFail: onFail)
    }

    func saveUserDetails(userDetails: JobPoster, onSuccess: @escaping ApiSuccessScenario, onFail:    @escaping ApiFailScenario ) {
        self.parseDb.saveCSObject(object: userDetails, onSuccess: onSuccess, onFail: onFail)
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
        let user = self.getCurrentUser()
        self.parseDb.getAllJobsOpportunitiesBy(ownerID: user, jobStatus: jobStatus, onSuccess: onSuccess, onFail: onFail)
    }

    func markAsDone(the job: JobOpportunity, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        job.status = JobStatus.done.rawValue
        self.parseDb.update(job: job, onSuccess: onSuccess, onFail: onFail)
    }
}

// MARK: Apply Flow Methods

extension ApiController {
    enum ApplyFlowError: Error {
        case None
    }

    func apply(to job: JobOpportunity, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {

        //Set current user as applier
        let user = self.getCurrentUser()
        let relation = job.relation(forKey: "appliedId")
        relation.add(user)

        //Update status to applied
        job.status = JobStatus.applied.rawValue

        //let deal = Deal(cleaner: user, job: job)
        //TODO: save the deal object on Parse

        self.parseDb.update(job: job, onSuccess: onSuccess, onFail: onFail)
    }

    func getAllJobOpportunitiesInRange(onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        let user = self.getCurrentUser()
        self.parseDb.getAllJobOpportunitiesInRange(for: user, onSuccess: onSuccess, onFail: onFail)
    }
}
