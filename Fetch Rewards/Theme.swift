//
//  Theme.swift
//  Fetch Rewards
//
//  Created by Lotanna Igwe-Odunze on 1/29/21.
//

import UIKit

struct Theme {
    
    struct Spacing {
        static var small: CGFloat = 10.0
        static var medium: CGFloat = 20.0
        static var large: CGFloat = 40.0
    }
    
    struct Font {
        static var header: UIFont = UIFont(name: "Helvetica-Bold", size: 24) ?? .systemFont(ofSize: 24, weight: .heavy)
        static var subheader: UIFont = UIFont(name: "Helvetica-Bold", size: 18) ?? .systemFont(ofSize: 18, weight: .bold)
        static var body: UIFont = UIFont(name: "Helvetica", size: 16) ?? .systemFont(ofSize: 16, weight: .regular)
        static var smallBody: UIFont = UIFont(name: "Helvetica", size: 14) ?? .systemFont(ofSize: 14, weight: .light)
    }
    
    struct Colour {
        
        static var onyx: UIColor = UIColor(red: 57/255, green: 57/255, blue: 58/255, alpha: 1.0)
        static var headingsColor: UIColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        static var bodyColor: UIColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }
}
