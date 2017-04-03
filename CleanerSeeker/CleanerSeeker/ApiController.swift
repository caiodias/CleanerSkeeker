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
    var memoryDb: MemoryDatabase
    let parseDb: ParseController

    init(database: WhereSave) {
        self.whereSave = database

        self.memoryDb = MemoryDatabase()
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

        switch whereSave {
            case .Memory:
                do {
                    try self.memoryDb.addUser(user: newUser)
                    onSuccess(newUser as AnyObject)
                } catch {
                    onFail(LoginFlowError.UserAlreadyExists)
                }

                break
            case .Parse:
                self.parseDb.addUser(user: newUser, password: "", onSuccess: onSuccess, onFail: onFail)
                break
        }
    }

    func loginUser(login: String, password: String, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario) {
        switch whereSave {
        case .Memory:
            if let userLogged = self.memoryDb.loginUser(login: login, password: password) {
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
