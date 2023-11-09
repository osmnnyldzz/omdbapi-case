//
//  UICollectionView+Extensions.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 8.11.2023.
//
import UIKit

extension UICollectionView {
    /// CollectionView'a CustomNib kayıtlamak için kısa yol.
    final func registerCell(type: UICollectionViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: identifier ?? cellId)
    }
}
