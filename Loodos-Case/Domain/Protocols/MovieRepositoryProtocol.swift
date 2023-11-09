//
//  MovieRepositoryProtocol.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 7.11.2023.
//

protocol MovieRepositoryProtocol {
    func fetchMovie(_ searchText:String, _ completion: @escaping (Constants.MovieResponse) -> Void)
}
