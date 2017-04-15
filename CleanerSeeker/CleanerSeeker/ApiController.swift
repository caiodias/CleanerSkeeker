//
//  ApiController.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

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

}

// MARK: Post Flow Methods

extension ApiController {
    enum PostFlowError: Error {
        case PostNotFound
    }

    func registerJobOpportunity(user: JobPoster, job: JobOpportunity, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        user.jobOpportunities.append(job)
        self.parseDb.registerJobOpportunity(user: user, onSuccess: onSuccess, onFail: onFail)
    }

    func getAllJobOpportunitiesInRange(user: Worker, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.parseDb.getAllJobOpportunitiesInRange(user: user, onSuccess: onSuccess, onFail: onFail)
    }
}

// MARK: Apply Flow Methods

extension ApiController {
    enum ApplyFlowError: Error {
        case None
    }

    func apply(toJob: JobOpportunity, worker: Worker, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        toJob.appliedId = worker.objectId
        self.parseDb.apply(toJob: toJob, onSuccess: onSuccess, onFail: onFail)
    }
}
