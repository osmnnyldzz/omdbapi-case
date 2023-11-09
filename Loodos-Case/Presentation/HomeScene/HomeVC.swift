//
//  HomeVC.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 7.11.2023.
//

import UIKit

final class HomeVC: BaseVC {
    // MARK: - Constants
    private let viewModel = HomeViewModel()
    
    
    // MARK: - Variables
    private var movies:[MovieBean]? = []
    private var emptyView: UIEmptyView?
    

    // MARK: - IBOutlet Area
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        self.listenVM()
    }
}

// MARK: - Functions and Methods
extension HomeVC {

    private func prepareUI() {
        self.title = "Loodos Film"
        self.collectionView.registerCell(type: MovieCollectionViewCell.self)
        
        if let movies = self.movies, movies.isEmpty {
            self.emptyView = UIEmptyView()
            self.emptyView?.delegate = self
            self.emptyView?.configrations(.searchEmpty)
            self.collectionView.backgroundView = emptyView
        }
    }
    
    private func fetchMovie(for searchText:String) {
        self.clearCV()
        
        self.viewModel.fetchMovie(searchText) { [weak self] response in
            DispatchQueue.main.async {
                self?.movies = response.search
                self?.collectionView.backgroundView = nil
                self?.collectionView.reloadData()
            }
        }
    }
    
    // Tüm viewmodel dinlemelerini tek fonksiyonda topladık.
    private func listenVM() {
        // Viewmodel istek attıktan sonra hata durumları tetiklendiği zaman burada karşılıyoruz.
        self.viewModel.showErrorPage = {
            self.emptyView?.configrations(.searchError)
            self.collectionView.backgroundView = self.emptyView
        }
        
        // Viewmodel istek attıktan sonra loading indicator'u gösteriyoruz.
        self.viewModel.showLoading = {
            self.loadingState(true)
        }
        
        // Viewmodel istek attıktan sonra loading indicator'u gizliyoruz.
        self.viewModel.hideLoading = {
            self.loadingState(false)
        }
        
        /*
         Aslında tek bir closure ile de çözebiliriz fakat ben biraz daha rahat okunması için
         bu şekilde yaptım.
         */
    }
    
    private func clearCV() {
        self.movies?.removeAll()
        self.collectionView.reloadData()
    }
}
// MARK: - CollectionView - Delegate & DataSource
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier,
                                                            for: indexPath) as? MovieCollectionViewCell 
        else { fatalError("Cell tanımlanamadı.")}
        
        if let movie = self.movies?[indexPath.row] {
            cell.setCell(with: movie)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedData = self.movies?[indexPath.row] {
            let detailVC:DetailVC = .instantiate()
            detailVC.movie = selectedData
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}

// MARK: - CollectionView - DelegateFlow
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Her hangi bir ratio değeri olmadığı için 180'i hardcode olarak bastım.
        CGSize(width: (self.view.frame.width / 3) - 12 , height: 180)
    }
}

// MARK: - SearchBarDelegate
extension HomeVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            self.fetchMovie(for: searchText)
            self.view.endEditing(true)
        }
    }
}

// MARK: - Custom Delegates
extension HomeVC: UIEmptyViewDelegate {
    func showMeButtonTapped() {
        self.searchBar.text = "Test"
        self.fetchMovie(for: "Test")
    }
}
