//
//  MovieCollectionViewCell.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 7.11.2023.
//

import UIKit
import Kingfisher
import Foundation

final class MovieCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    static let identifier = "MovieCollectionViewCell"

    
    // MARK: - IBOutlet Area
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.addBorder()
        }
    }
    @IBOutlet weak var yearContainerView: UIView! {
        didSet {
            self.yearContainerView.addBorder(color: .clear)
            self.yearContainerView.cornerRadius()
        }
    }
}

// MARK: - Functions and Methods
extension MovieCollectionViewCell {
    func setCell(with movie:MovieBean) {
        self.movieTitleLabel.text = movie.title ?? ""
        self.yearLabel.text = movie.year ?? ""
        
        let url = URL(string: movie.poster ?? "")
        self.posterImageView.kf.setImage(with: url, placeholder: UIImage(named: "image"))
    }
}
