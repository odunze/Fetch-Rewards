//
//  EventsModel.swift
//  Fetch Rewards
//
//  Created by Lotanna Igwe-Odunze on 1/29/21.
//

import UIKit

struct Events: Codable {
    let events: [Event]
}

struct Event: Codable {
    let id: Int
    let venue: Venue
    let performers: [Performer]
    let datetimeLocal: String
    let title: String
    let eventDescription: String
    
    var image: UIImage?
    
    var prettyLocation: String {
        return "\(venue.city), \(venue.state)"
    }
    
    var prettyDateTime: String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date: Date = inputDateFormatter.date(from: datetimeLocal) else {
            return "TBD"
        }

        let outputDateFormatter = DateFormatter()
        
        outputDateFormatter.dateFormat = "EEEE, d MMM, yyyy"
        let prettyDate = outputDateFormatter.string(from: date)
        
        outputDateFormatter.dateFormat = "h:mm a"
        let prettyTime = outputDateFormatter.string(from: date)
        
        let prettyDateTime: String = "\(prettyDate) \n\(prettyTime)"
        return prettyDateTime
    }

    enum CodingKeys: String, CodingKey {
        case id
        case venue
        case performers
        case datetimeLocal = "datetime_local"
        case title
        case eventDescription = "description"
    }
}

struct Venue: Codable {
    let state: String
    let city: String
}

struct Performer: Codable {
    let image: String
}
