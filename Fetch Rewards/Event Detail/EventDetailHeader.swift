//
//  EventDetailHeader.swift
//  Fetch Rewards
//
//  Created by Lotanna Igwe-Odunze on 1/29/21.
//

import UIKit

class EventDetailHeader: UIView {
    var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.font = Theme.Font.header
        label.textColor = Theme.Colour.headingsColor
        label.textAlignment = .left
        return label
    }()
    
    var faveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func setFavourite(fave: Bool) {
        let title = fave ? "❤️" : "🤍"
        faveButton.setTitle(title, for: .normal)
    }
    
    private var contentStack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.spacing = Theme.Spacing.medium
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: Theme.Spacing.medium, left: 0.0, bottom: Theme.Spacing.small, right: Theme.Spacing.medium)
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(faveButton)
        
        addSubview(backButton)
        addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: Theme.Spacing.medium),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.Spacing.medium),
            backButton.heightAnchor.constraint(equalToConstant: 24.0),
            backButton.widthAnchor.constraint(equalToConstant: 24.0),
            
            faveButton.widthAnchor.constraint(equalToConstant: 28.0),
            
            contentStack.topAnchor.constraint(equalTo: topAnchor),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentStack.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: Theme.Spacing.medium),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
