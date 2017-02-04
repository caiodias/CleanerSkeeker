//
//  ApiController.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Foundation

typealias ApiSuccessScenario = (AnyObject) -> Void
typealias ApiFailScenario = (Error) -> Void

class ApiController {
//    let callBack =
//    self.loginCallback = onCompletion
    
    func registerUser() -> String {
        return "Caio"
    }
    
    func registerUser(user: User, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        // TODO:
        // Call the api, register the user object on it.
    }
}
