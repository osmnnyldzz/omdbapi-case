//
//  FirebaseManager.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 7.11.2023.
//

import FirebaseCore
import FirebaseRemoteConfig
import FirebaseAnalytics
import FirebaseMessaging

final class FirebaseManager {
    static let instance = FirebaseManager()
    
    private var remoteConfig:RemoteConfig?
    private var remoteSetting = RemoteConfigSettings()
    
    private init() {
    }
    
    func configure() {
        FirebaseApp.configure()
        Analytics.setAnalyticsCollectionEnabled(true)
        self.remoteConfig = RemoteConfig.remoteConfig()
    }
    
    func messaging() -> Messaging {
        return Messaging.messaging()
    }
    
    func setAnalytics(with parameters: [String:String], for page:String) {
        DispatchQueue.global(qos: .background).async {
            Analytics.logEvent(page, parameters: parameters)
        }
    }
    
    func fetchRemoteConfig(with valuePath:String, completion: @escaping (RemoteConfigValue) -> ()) {
        self.remoteSetting.minimumFetchInterval = 0
        self.remoteConfig?.configSettings = remoteSetting
        
        self.remoteConfig?.fetch { [weak self] (status, error) -> Void in
            if status == .success {
                self?.remoteConfig?.activate { [weak self] changed, error in
                    if let value = self?.remoteConfig?.configValue(forKey: valuePath) {
                        completion(value)
                    }
                }
            } else {
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        }
    }
    
}
