//
//  Indicator.swift
//  RXSwiftDemo
//
//  Created by Semicolon on 27/11/2022.
//

import UIKit

@available(iOS 13.0, *)
struct Indicator {
    
    static let indicator = UIActivityIndicatorView(style: .large)
    @available(iOS 13.0, *)
    static func createIndicator(on vc: UIViewController, start: Bool) {
        indicator.center = vc.view.center
        indicator.color = UIColor(named: "darkBlue") ?? .red
        vc.view.addSubview(indicator)
        if start {
            indicator.startAnimating()
        }else {
            indicator.stopAnimating()
        }
    }
}
