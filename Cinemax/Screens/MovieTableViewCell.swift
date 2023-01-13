//
//  MovieTableViewCell.swift
//  Cinemax
//
//  Created by Humberto Rodrigues on 13/01/23.
//

import UIKit
import Kingfisher

class MovieTableViewCell: ViewCell { // ViewCell herda de UITableViewCell
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var poster: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [lbTitle, lbGenres, ratingStackView]) //arrangedSubviews: ja inclui meu lbTitle na hierarquia das subviews, não preciso inclui-lo no protocolo SubView
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        return stack
    }()
    
    private lazy var lbTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var lbGenres: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var blur: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    private lazy var ratingStackView = {
        let stack = UIStackView(arrangedSubviews: [imgStar, lbRating])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    private lazy var lbRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var imgStar: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "star")
        image.tintColor = .yellow
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViewCode()
        
    }
    
    func configure(movie: Movie) {
        if let ratingScore = movie.rating?.average {
            lbRating.text = "\(ratingScore)"
        }
        lbTitle.text = movie.name
        lbGenres.text = movie.genres?.joined(separator: ", ")
        guard let imageString = movie.image?.medium, let imgURL = URL(string: imageString) else {return}
        poster.kf.setImage(with: imgURL)
    }
    
    
}

extension MovieTableViewCell: ViewCode {
    func setView() {
        contentView.addSubview(containerView)
        containerView.addSubview(blur)
        containerView.addSubview(stackView)
        containerView.addSubview(poster)
        
    }
    
    func setContrains() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
            
            poster.topAnchor.constraint(equalTo: containerView.topAnchor),
            poster.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            poster.widthAnchor.constraint(equalToConstant: 120),
            poster.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -16),
            
            blur.topAnchor.constraint(equalTo: containerView.topAnchor),
            blur.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            blur.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            imgStar.widthAnchor.constraint(equalToConstant: 20),
            imgStar.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func extraChanges() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    
}

class ViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



