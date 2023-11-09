//
//  MovieRepository.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 7.11.2023.
//

final class MovieRepository: MovieRepositoryProtocol {
    
    private let network = ApiService()
    
    // Router'dan destek alarak, Search edilen text ile servise istek atıyoruz.
    func fetchMovie(_ searchText:String, _ completion: @escaping (Constants.MovieResponse) -> Void) {
        self.network.request(APIRouter.fetchMovie(searchText: searchText)) { (result: Constants.MovieResponse) in
            switch result {
            case .success(let value):
                return completion(.success(value))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}
