//
//  LocationController.swift
//  CleanerSeeker
//
//  Created by Orest Hazda on 18/04/17.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Foundation

struct Location {
    let latitude: Double
    let longitude: Double
}

typealias LocationSuccessResponse = (Location) -> Void
typealias LocationFailResponse = (Error) -> Void

class LocationController {

    static var baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?"
    static var apiKey = "AIzaSyASY6sh69_ULlZPOo-zjZPShTOdEQ0bUL8"

    enum LocationFetchErrors: Error {
        case NotFound
        case CantParseResponse
        case WrongRequest
    }

    static func composeUrl(queryItems: [URLQueryItem]) -> URL? {
        var baseUrlObject = URLComponents(string: LocationController.baseUrl)

        baseUrlObject?.queryItems = queryItems

        return baseUrlObject?.url
    }

    static func getCordinatesByAddress(street: String, zipCode: String, onSuccess: LocationSuccessResponse, onFail: LocationFailResponse) {

        let params = [
            URLQueryItem(name: "address", value: "\(street)+\(zipCode)"),
            URLQueryItem(name: "key", value: LocationController.apiKey)
        ]

        let url = LocationController.composeUrl(queryItems: params)

        do {

            let data = try Data(contentsOf: url!)

            guard let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] else {
                onFail(LocationFetchErrors.CantParseResponse)
                return
            }

            if let results = json["results"] as? [AnyObject] {
                if !results.isEmpty {
                    if let geometry = results[0]["geometry"] as? [String:AnyObject] {
                        if let location = geometry["location"] as? [String: AnyObject] {

                            //@TODO Refactor it later 
                            let latitude = location["lat"] as! Double
                            let longitude = location["lng"] as! Double

                            let coordinats = Location(latitude: latitude, longitude: longitude)
                            onSuccess(coordinats)
                        } else {
                            onFail(LocationFetchErrors.NotFound)
                        }
                    }
                } else {
                    onFail(LocationFetchErrors.NotFound)
                }
            }

        } catch {
            onFail(LocationFetchErrors.WrongRequest)
        }

    }

    static func getAddressByCordinates() {

    }
}
