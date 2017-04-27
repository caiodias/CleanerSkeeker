//
//  Facade.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Foundation

class Facade {
    private let apiController = ApiController()
    private let locationController = LocationController()

    // MARK: Singleton
    static let shared: Facade = {
        let instance = Facade()
        return instance
    }()

    private init() {
        // nothing to see here, keep moving 😁
    }

    // MARK: Login Flow

    public func registerUser(user: CSUser, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.apiController.registerCSUser(user: user, onSuccess: onSuccess, onFail: onFail)
    }

    public func loginUser(login: String, password: String, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.apiController.loginUser(login: login, password: password, onSuccess: onSuccess, onFail: onFail)
    }

    public func resetPassword(email: String, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.apiController.resetPassword(email: email, onSuccess: onSuccess, onFail: onFail)
    }

    public func logout(onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.apiController.logout(onSuccess: onSuccess, onFail: onFail)
    }

    public func updateUser(user: CSUser, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.apiController.updateUser(user: user, onSuccess: onSuccess, onFail: onFail)
    }

    public func updateUserAvatar(image: Data, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.apiController.updateUserAvatar(image: image, onSuccess: onSuccess, onFail: onFail)
    }

    func getUserProfileImage(image: CSFile, onSuccess: @escaping ApiSuccessScenario, onFail:    @escaping ApiFailScenario) {
        self.apiController.getUserProfileImage(image:image, onSuccess: onSuccess, onFail: onFail)
    }

    func updateCurrentUserLoccation() {
        self.apiController.updateCurrentUserLocation()
    }

    // MARK: Post Flow

    public func registerJobOpportunity(job: JobOpportunity, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.apiController.registerJobOpportunity(job: job, onSuccess: onSuccess, onFail: onFail)
    }

    public func getAllJobsOpportunitiesBy(jobStatus: JobStatus, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.apiController.getAllJobsOpportunitiesBy(jobStatus: jobStatus, onSuccess: onSuccess, onFail: onFail)
    }

    public func markAsDone(the job: JobOpportunity, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.apiController.markAsDone(the: job, onSuccess: onSuccess, onFail: onFail)
    }

    // MARK: Apply Flow

    public func getJobsInRange(onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.apiController.getAllJobOpportunitiesInRange(onSuccess: onSuccess, onFail: onFail)
    }

    public func apply(to job: JobOpportunity, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.apiController.apply(to: job, onSuccess: onSuccess, onFail: onFail)
    }

    // MARK: Location Helper

    public func getCurrentLocation(address: String, zipCode: String, onSuccess: @escaping LocationSuccessResponse, onFail: @escaping LocationFailResponse ) {
        LocationController.getCordinatesByAddress(street: address, zipCode: zipCode, onSuccess: onSuccess, onFail: onFail)
    }
}
