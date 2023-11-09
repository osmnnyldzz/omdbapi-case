//
//  UIEmptyView.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 8.11.2023.
//

import UIKit
import Lottie

// MARK: - Protocols
protocol UIEmptyViewDelegate {
    func showMeButtonTapped()
}

final class UIEmptyView: UIView {
    // MARK: - Variables
    var delegate:UIEmptyViewDelegate?
    private var animView: LottieAnimationView!

    
    // MARK: - IBOutlet Area
    @IBOutlet weak var animContainerView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var showMeButton: UIButton! {
        didSet {
            self.showMeButton.addBorder(width: 1, color: .black, radius: 4)
        }
    }
    @IBAction func showMeButtonTapped(_ sender: UIButton) {
        delegate?.showMeButtonTapped()
    }

    // MARK: - Init Area
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initalize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initalize()
    }

    private func initalize() {
        let uiNib = UINib(nibName: "UIEmptyView", bundle: nil)
        guard let view = uiNib.instantiate(withOwner: self).first as? UIView else { fatalError("") }
        view.frame = bounds
        addSubview(view)
    }
}
// MARK: - Functions and Methods
extension UIEmptyView {
    func configrations(_ name:GIF) {
        if !self.animContainerView.subviews.isEmpty {
            self.animView.removeFromSuperview()
        }
        self.animView = .init(name: name.rawValue)
        self.animView.frame = self.animContainerView.bounds
        self.animView.contentMode = .scaleAspectFit
        self.animView.loopMode = .loop
        self.animContainerView.addSubview(animView)
        self.animView.play()
    }
}
