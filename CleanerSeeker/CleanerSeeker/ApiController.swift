//
//  ApiController.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

enum WhereSave: Int {
    case Memory
    case Parse
}

typealias ApiSuccessScenario = (AnyObject) -> Void
typealias ApiFailScenario = (Error) -> Void

class ApiController {
    let whereSave: WhereSave
    var memoryDb: MemoryDatabase?

    init(database: WhereSave) {
        self.whereSave = database

        if self.whereSave == .Memory {
            self.memoryDb = MemoryDatabase()
        }
    }
}

// MARK: Login Flow Methods
extension ApiController {
    enum LoginFlowError: Error {
        case UserNotFound
        case UserAlreadyExists
    }

    func registerUser(user: User, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        switch whereSave {
            case .Memory:
                do {
                    try self.memoryDb!.addUser(user: user)
                    onSuccess(user as AnyObject)
                } catch {
                    onFail(LoginFlowError.UserAlreadyExists)
                }

                break
            case .Parse:
                // TODO: Implement the call using Parse framework
                break
        }
    }

    func loginUser(login: String, password: String, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        switch whereSave {
        case .Memory:
            if let userLogged = self.memoryDb!.loginUser(login: login, password: password) {
                onSuccess(userLogged as AnyObject)
            } else {
                onFail(LoginFlowError.UserNotFound)
            }
            break
        case .Parse:
            // TODO: Implement the call using Parse framework
            break
        }
    }
}
