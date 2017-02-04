//
//  Deal.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Foundation

class Deal {
    let selector: Selector
    let jobPoster: JobPoster
    let date: Date
    
    init(selector: Selector, jobPoster: JobPoster) {
        self.selector = selector
        self.jobPoster = jobPoster
        self.date = Date()
    }
}
