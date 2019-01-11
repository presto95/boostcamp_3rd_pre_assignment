//
//  UIAlertController+.swift
//  BoxOffice
//
//  Created by Presto on 04/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func alert(title: String?, message: String?, style: UIAlertController.Style = .alert) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        return alert
    }
    
    func action(title: String?, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        addAction(action)
        return self
    }
    
    func present(to viewController: UIViewController, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            viewController.present(self, animated: true, completion: completion)
        }
    }
}
