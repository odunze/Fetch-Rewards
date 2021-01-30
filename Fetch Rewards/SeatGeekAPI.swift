//
//  SeatGeekAPI.swift
//  Fetch Rewards
//
//  Created by Lotanna Igwe-Odunze on 1/29/21.
//

import Foundation

struct API {
    static var clientID: String = "MjE1MDk5NjB8MTYxMTEwMDQyOS4xNzAxMzgx"
    
    static var base: String = "https://api.seatgeek.com/2"
    
    enum Endpoint {
        case events
        case event(id: String)
        
        var path: String {
            switch self {
            
            case .events:
                return "\(base)/events?client_id=\(clientID)"
            case .event(let id):
                return "\(base)/events/{\(id)}?client_id=\(clientID)"
            }
        }
    }
}
