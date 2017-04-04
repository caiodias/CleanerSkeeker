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

    // MARK: Singleton
    static let shared: Facade = {
        let instance = Facade()
        return instance
    }()

    private init() {
        // nothing to see here, keep moving 😁
    }

    public func registerUser(user: User, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.apiController.registerUser(user: user, onSuccess: onSuccess, onFail: onFail)
    }

    public func loginUser(login: String, password: String, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.apiController.loginUser(login: login, password: password, onSuccess: onSuccess, onFail: onFail)
    }

    public func resetPassword(email: String, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        self.apiController.resetPassword(email: email, onSuccess: onSuccess, onFail: onFail)
    }
}
