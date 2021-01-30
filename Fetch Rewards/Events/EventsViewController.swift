//
//  EventsViewController.swift
//  Fetch Rewards
//
//  Created by Lotanna Igwe-Odunze on 1/29/21.
//

import UIKit

class EventsViewController: UITableViewController {
    
    var viewmodel: EventsViewModel
    var cellReuseID: String
    
    private var searchController: UISearchController = {
        let ctlr = UISearchController(searchResultsController: nil)
        ctlr.definesPresentationContext = true
        ctlr.searchBar.placeholder = "Search events"
        ctlr.searchBar.barTintColor = Theme.Colour.onyx
        return ctlr
    }()
    
    private func statusBar(color: UIColor) {
        let frame: CGRect
        if #available(iOS 13.0, *) {
            frame = navigationController?.view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            frame = UIApplication.shared.statusBarFrame
        }
        
        let view = UIView(frame: frame)
        view.backgroundColor = color
        navigationController?.view.addSubview(view)
    }
    
    init(viewModel: EventsViewModel) {
        self.viewmodel = viewModel
        self.cellReuseID = "eventCell"
        super.init(nibName: nil, bundle: nil)
        
        searchController.searchResultsUpdater = self
        
        tableView.register(EventCell.self, forCellReuseIdentifier: cellReuseID)
        tableView.rowHeight = 150
        tableView.tableHeaderView = searchController.searchBar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewmodel.fetchEvents { success in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        statusBar(color: Theme.Colour.onyx)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        tableView.reloadData()
    }
}

extension EventsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewmodel.loadEvents(term: searchController.searchBar.text)
        tableView.reloadData()
    }
}
