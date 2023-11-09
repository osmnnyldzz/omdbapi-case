//
//  HomeViewModel.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 7.11.2023.
//

import UIKit

final class HomeViewModel:BaseViewModel {
    private let repository = MovieRepository()
    
    /// VC içerisinde dinlediğimiz bir closure. Hata ekranını göstermek için kullanıyoruz.
    var showErrorPage: () -> () = {}
    
    /// Repository'e bağlanıp search edilen Text'e göre verileri çekmek için kullanıyoruz.
    func fetchMovie(_ searchText:String, _ completion: @escaping (Movie) -> Void) {
        self.showLoading()
        
        self.repository.fetchMovie(searchText) { [weak self] (result: Constants.MovieResponse) in
            self?.hideLoading()
            
            switch result {
            case .success(let value):
                if value.search?.count ?? 0 > 0 {
                    completion(value)
                } else {
                    self?.showErrorPage()
                }
            case .failure(_):
                self?.showErrorPage()
            }
            
        }
    }
}
