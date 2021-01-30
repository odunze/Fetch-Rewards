//
//  EventsViewModel.swift
//  Fetch Rewards
//
//  Created by Lotanna Igwe-Odunze on 1/29/21.
//

import UIKit

protocol EventManager {
    func titleFor(eventId: Int) -> String
    func imageFor(eventId: Int) -> UIImage?
    func locationFor(eventId: Int) -> String
    func dateAndTimeFor(eventId: Int) -> String
    func setFavourite(eventId: Int)
    func isFavourite(eventId: Int) -> Bool
}

class EventsViewModel {
    private let userDefaults = UserDefaults.standard
    
    private var allEvents: [Event] = []
    
    var events: [Event] = []
    
    func loadEvents(term: String?) {
        if !allEvents.isEmpty,
              let searched = term,
              !searched.isEmpty
        {
            let results = allEvents.filter { event -> Bool in
                return event.title.contains(searched)
            }
            events = results
        } else {
            events = allEvents
        }
    }
    
    func fetchEvents(completion: @escaping (Bool) -> () ) {
        
        guard let eventsURL = URL(string: API.Endpoint.events.path) else {
            fatalError("Expected Events API Endpoint")
        }
        
        let networkTask = URLSession.shared.dataTask(with: eventsURL) { (data, URLresponse, error) in
            if let fetchError = error {
                print("Error downloading events: \(fetchError.localizedDescription).")
                completion(false)
            }
            
            if let eventsData = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let decodedEvents = try jsonDecoder.decode(Events.self, from: eventsData)
                    self.allEvents = decodedEvents.events
                    self.loadEvents(term: nil)
                    completion(true)
                } catch {
                    print("Error decoding Events data: \(error.localizedDescription).")
                    completion(false)
                }
            }
        }
        networkTask.resume()
    }
    
    func fetchImage(for event: Event, completion: @escaping (Bool) ->() ) {
        
        guard let imageString = event.performers.first?.image,
              let url = URL(string: imageString) else {
            fatalError("Expected Image URL")
        }
        
        let networkTask = URLSession.shared.dataTask(with: url) { (data, URLresponse, error) in
            if let fetchError = error {
                print("Error downloading image: \(fetchError.localizedDescription).")
                completion(false)
            }
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                if let index = self.allEvents.firstIndex(where: { $0.id == event.id }) {
                    self.allEvents[index].image = image
                    self.loadEvents(term: nil)
                }
                completion(true)
            } else { //Success is ALSO defined as having no image to display since not all events may have an image.
                print("No image but that's okay")
                completion(true)
            }
        }
        networkTask.resume()
    }
    
    private func isFaved(eventId: String) -> Bool {
        return userDefaults.bool(forKey: eventId)
    }
}

extension EventsViewModel: EventManager {
    
    func titleFor(eventId: Int) -> String {
        guard let event = allEvents.first(where: {$0.id == eventId } ) else {
            fatalError("Expected Event")
        }
        return event.title
    }
    
    func imageFor(eventId: Int) -> UIImage? {
        guard let event = allEvents.first(where: {$0.id == eventId } ) else {
            fatalError("Expected Event")
        }
        return event.image
    }
    
    func locationFor(eventId: Int) -> String {
        guard let event = allEvents.first(where: {$0.id == eventId } ) else {
            fatalError("Expected Event")
        }
        return event.prettyLocation
    }
    
    func dateAndTimeFor(eventId: Int) -> String {
        guard let event = allEvents.first(where: {$0.id == eventId } ) else {
            fatalError("Expected Event")
        }
        return event.prettyDateTime
    }
    
    func setFavourite(eventId: Int) {
        let eventKey = String(eventId)
        if isFaved(eventId: eventKey) {
            userDefaults.set(false, forKey: eventKey)
        } else {
            userDefaults.set(true, forKey: eventKey)
        }
        userDefaults.synchronize()
    }
    
    func isFavourite(eventId: Int) -> Bool {
        let eventKey = String(eventId)
        return userDefaults.bool(forKey: eventKey)
    }
}
