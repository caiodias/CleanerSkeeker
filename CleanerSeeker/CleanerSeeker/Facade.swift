//
//  Facade.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Foundation

class Facade {
    private let _apiController = ApiController()
    
    // MARK: Singleton
    static let shared: Facade = {
        let instance = Facade()
        return instance
    }()
    
    private init() {
        // nothingto see here, keep moving :D
    }
    
    public func registerUser(user: User, onSuccess: @escaping ApiSuccessScenario, onFail: @escaping ApiFailScenario){
        self._apiController.registerUser(user: user, onSuccess: onSuccess, onFail: onFail)
    }
    
    public func listUser() -> [String] {
        return fillUserArray()
    }
    
    private func fillUserArray() -> [String] {
        var userArray = [String]()
        userArray.append("A")
        userArray.append("B")
        userArray.append("C")
        userArray.append("D")
        
        return userArray
    }
}
