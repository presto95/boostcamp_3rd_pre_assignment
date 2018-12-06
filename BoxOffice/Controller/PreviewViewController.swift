//
//  PreviewViewController.swift
//  BoxOffice
//
//  Created by Presto on 06/12/2018.
//  Copyright © 2018 presto. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    var image: UIImage?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:))))
        return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.delegate = self
        scrollView.maximumZoomScale = 3
        scrollView.addSubview(imageView)
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
    }
    
    @objc private func didTapImageView(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

extension PreviewViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
