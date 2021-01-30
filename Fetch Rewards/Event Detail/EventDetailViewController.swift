//
//  EventDetailViewController.swift
//  Fetch Rewards
//
//  Created by Lotanna Igwe-Odunze on 1/29/21.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    private var eventID: Int
    private var manager: EventManager
    private var header: EventDetailHeader = EventDetailHeader(frame: .zero)
    
    private var heroImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 20.0
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var dateTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.font = Theme.Font.subheader
        label.textColor = Theme.Colour.headingsColor
        return label
    }()
    
    private var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.Font.body
        label.textColor = Theme.Colour.bodyColor
        return label
    }()
    
    private var detailStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: Theme.Spacing.small, left: Theme.Spacing.medium, bottom: Theme.Spacing.small, right: Theme.Spacing.medium)
        return stack
    }()
    
    private func configureViews() {
        header.setTitle(title: manager.titleFor(eventId: eventID))
        header.setFavourite(fave: manager.isFavourite(eventId: eventID))
        heroImage.image = manager.imageFor(eventId: eventID)
        dateTimeLabel.text = manager.dateAndTimeFor(eventId: eventID)
        locationLabel.text = manager.locationFor(eventId: eventID)
    }
    
    private func faveUnfave() {
        manager.setFavourite(eventId: eventID)
        
        let favedStatus = manager.isFavourite(eventId: eventID)
        header.setFavourite(fave: favedStatus)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 120.0),
            
            heroImage.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.33),
            
            heroImage.topAnchor.constraint(equalTo: header.bottomAnchor, constant: Theme.Spacing.small),
            heroImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Theme.Spacing.medium),
            heroImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Theme.Spacing.medium),
            
            dateTimeLabel.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: Theme.Spacing.large),
            dateTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Theme.Spacing.medium),
            dateTimeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Theme.Spacing.medium),

            locationLabel.topAnchor.constraint(equalTo: dateTimeLabel.bottomAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Theme.Spacing.medium),
            locationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Theme.Spacing.medium)
        ])
    }

    init(id: Int, manager: EventManager) {
        self.manager = manager
        self.eventID = id
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        
        header.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        header.faveButton.addTarget(self, action: #selector(faveButtonTapped(_:)), for: .touchUpInside)

        view.addSubview(header)
        view.addSubview(heroImage)
        view.addSubview(dateTimeLabel)
        view.addSubview(locationLabel)
        
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    @objc func faveButtonTapped(_ sender: UIButton) {
        faveUnfave()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
