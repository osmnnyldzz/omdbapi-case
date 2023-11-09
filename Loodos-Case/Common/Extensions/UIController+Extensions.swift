//
//  UIController+Extensions.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 7.11.2023.
//

import UIKit

extension UIAlertController {
    func addAction(title: String?, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)? = nil) {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        self.addAction(action)
    }
}

extension UIViewController {
    func showAlert(title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(title: "Tamam")
        present(alert, animated: true, completion: nil)
    }
    
    /// Storyboard'ı Main olan viewController'ları set etmek için kullanılır. Main dışındakiler de hata fırlatacaktır.
    static func instantiate<T>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "\(T.self)") as? T else {
            fatalError("Controller bulunamadı.")
        }
        return controller
    }
}
