//
//  PrepareVC.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 7.11.2023.
//

import UIKit

final class PrepareVC: UIViewController {
    // MARK: - Variables
    var window: UIWindow?
    
    
    // MARK: - IBOutlet Area
    @IBOutlet weak var splashTitle: UILabel!
    
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkNetworkConnection()
    }
}

// MARK: - Functions and Methods
extension PrepareVC {
    
    private func checkNetworkConnection() {
        if Helper.checkNetwork() {
            self.requestRemoteConfig()
        } else {
            DispatchQueue.main.async {
                self.showAlert(title:"Hata", message:"Lütfen internet bağlantınızı kontrol ediniz.")
            }
        }
    }
    
    private func requestRemoteConfig() {
        FirebaseManager.instance.fetchRemoteConfig(with: "Loodos") { [weak self] (result) in
            DispatchQueue.main.async {
                self?.updateUI(with: result.stringValue)
            }
        }
    }
    
    private func updateUI(with value:String?) {
        DispatchQueue.main.async {
            self.splashTitle.text = value
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let vc:HomeVC = .instantiate()
            let navVC = UINavigationController(rootViewController: vc)
            self.window?.rootViewController = navVC
            self.window?.makeKeyAndVisible()
        }
    }
}
