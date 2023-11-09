//
//  BaseVC.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 8.11.2023.
//

import UIKit

class BaseVC: UIViewController {
        
    lazy var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.view.center
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.loadingView)
    }
    
    func loadingState(_ status: Bool) {
        switch status {
        case true:
            self.loadingView.startAnimating()
        case false:
            self.loadingView.stopAnimating()
        }
    }
}
