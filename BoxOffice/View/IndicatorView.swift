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
        let backgroundView: UIView = {
            let view = UIView()
            view.backgroundColor = .black
            view.layer.cornerRadius = 10
            view.clipsToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
            NSLayoutConstraint.activate([
                view.centerXAnchor.constraint(equalTo: centerXAnchor),
                view.centerYAnchor.constraint(equalTo: centerYAnchor),
                view.widthAnchor.constraint(equalToConstant: 80),
                view.heightAnchor.constraint(equalToConstant: 80)
                ])
            return view
        }()
        let _: UIActivityIndicatorView = {
            let view = UIActivityIndicatorView(style: .whiteLarge)
            view.startAnimating()
            view.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.addSubview(view)
            NSLayoutConstraint.activate([
                view.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
                view.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
                ])
            return view
        }()
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
