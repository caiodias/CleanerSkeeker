//
//  ApiController.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Parse

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

    // MARK: Private Methods
}
