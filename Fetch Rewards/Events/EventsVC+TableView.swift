//
//  EventsVC+TableView.swift
//  Fetch Rewards
//
//  Created by Lotanna Igwe-Odunze on 1/29/21.
//

import UIKit

extension EventsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! EventCell
        
        viewmodel.fetchImage(for: viewmodel.events[indexPath.row]) { success in
            if success {
                let event = self.viewmodel.events[indexPath.row]
                
                cell.configureCell(eventTitle: event.title, eventLocation: event.prettyLocation, eventDateTime: event.prettyDateTime, eventImage: event.image, favourite: self.viewmodel.isFavourite(eventId: event.id))
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = viewmodel.events[indexPath.row]
        let eventVC = EventDetailViewController(id: event.id, manager: viewmodel)
        self.navigationController?.pushViewController(eventVC, animated: true)
    }
}
