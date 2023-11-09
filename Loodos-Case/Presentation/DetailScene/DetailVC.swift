//
//  DetailVC.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 7.11.2023.
//

import UIKit
import Kingfisher

/* 
 
 "MARK : -" kullanımında bir satır fazla boşluk bırakıyorum.
 Geçerli sayfa içerisinde kod satırı fazla olduğu durumlar da Minimap'ten 
 başlıklara hızlı erişim sağlamak için kullanıyorum.
 
 */

final class DetailVC: BaseVC {
    
    // MARK: - Constants
    private let viewModel = DetailViewModel()
    
    
    // MARK: - IBOutlet Area
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    // MARK: - Variables
    var movie:MovieBean?
    
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.sendLog()
    }
    
}

// MARK: - Functions and Methods
extension DetailVC {
    private func bind() {
        if let movie = self.movie {
            self.title = movie.title ?? ""
            
            self.titleLabel.text = movie.title ?? ""
            self.movieYearLabel.text = movie.year ?? ""
            self.typeLabel.text = movie.type ?? ""
            
            let url = URL(string: movie.poster ?? "")
            self.posterImageView.kf.setImage(with: url, placeholder: UIImage(named: "image"))
        }
    }
    
    private func sendLog(){
        let page: String = "DetailVC"
        let movieData = [
            "title": self.movie?.title ?? "",
            "type": self.movie?.type ?? "",
            "year": self.movie?.year ?? "",
        ]
        FirebaseManager.instance.setAnalytics(with: movieData, for: page)
    }
}
