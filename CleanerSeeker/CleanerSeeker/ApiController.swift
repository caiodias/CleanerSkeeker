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

    func registerUser(user: User, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        var newUser = user.copy()
        newUser.email = user.email.lowercased()

        self.parseDb.addUser(user: newUser, password: "", onSuccess: onSuccess, onFail: onFail)
    }

    func loginUser(login: String, password: String, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        // TODO: Implement the call using Parse framework
    }

    //Reset user  password using user email
    func resetPassword(email: String, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.parseDb.requestPasswordReset(forEmail: email, onSuccess: onSuccess, onFail: onFail)

    }
}
