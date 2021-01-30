//
//  EventCell.swift
//  Fetch Rewards
//
//  Created by Lotanna Igwe-Odunze on 1/29/21.
//

import UIKit

class EventCell: UITableViewCell {
    
    private var thumbnail: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 20.0
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
     var favourite: UIButton = {
        let button = UIButton(frame: .zero)
        button.isHidden = true
        button.setTitle("❤️", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.font = Theme.Font.subheader
        label.textColor = Theme.Colour.headingsColor
        return label
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.Font.smallBody
        label.textColor = Theme.Colour.bodyColor
        return label
    }()
    
    var dateTimeLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.font = Theme.Font.smallBody
        label.textColor = Theme.Colour.bodyColor
        return label
    }()
    
    private var infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    func configureCell(eventTitle: String, eventLocation: String, eventDateTime: String, eventImage: UIImage?, favourite: Bool) {
        
        DispatchQueue.main.async {
            self.thumbnail.image = eventImage
            self.titleLabel.text = eventTitle
            self.locationLabel.text = eventLocation
            self.dateTimeLabel.text = eventDateTime
            self.favourite.isHidden = !favourite
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        infoStack.addArrangedSubview(thumbnail)
        infoStack.addArrangedSubview(titleLabel)
        infoStack.addArrangedSubview(locationLabel)
        infoStack.addArrangedSubview(dateTimeLabel)
        
        contentView.addSubview(thumbnail)
        contentView.addSubview(favourite)
        contentView.addSubview(infoStack)
        
        NSLayoutConstraint.activate([
            thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Theme.Spacing.small),
            thumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.Spacing.medium),
            thumbnail.widthAnchor.constraint(equalToConstant: 80.0),
            thumbnail.heightAnchor.constraint(equalToConstant: 80.0),
            
            favourite.topAnchor.constraint(equalTo: thumbnail.topAnchor),
            favourite.leadingAnchor.constraint(equalTo: thumbnail.leadingAnchor, constant: -Theme.Spacing.small),
            favourite.heightAnchor.constraint(equalToConstant: Theme.Spacing.medium),
            
            infoStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -Theme.Spacing.small),
            infoStack.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: Theme.Spacing.medium),
            infoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.Spacing.small)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
