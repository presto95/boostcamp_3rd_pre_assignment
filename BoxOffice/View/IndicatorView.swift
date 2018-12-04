//
//  IndicatorView.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class IndicatorView: UIView {

    static let shared = IndicatorView(frame: UIScreen.main.bounds)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let backgroundView = UIView()
        backgroundView.backgroundColor = .lightGray
        backgroundView.layer.cornerRadius = 10
        backgroundView.clipsToBounds = true
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: 80),
            backgroundView.heightAnchor.constraint(equalToConstant: 80)
            ])
        let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
            ])
    }
    
    func show() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            if let window = UIApplication.shared.keyWindow {
                window.addSubview(self)
            }
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.removeFromSuperview()
        }
    }
}
