//
//  TambolaNumberCell.swift
//  Tamblola
//
//  Created by Yash Bedi on 14/01/24.
//

import UIKit


final class TambolaNumberCell: UICollectionViewCell {
    
    private let numberView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCellWith(_ value: Int) {
        numberView.text = "\(value)"
    }
    
    func markGeneratedNumberAsSelected() {
        numberView.backgroundColor = .systemRed
    }
}

private extension TambolaNumberCell {
    
    func commonInit(){
        setup()
        setHierarchy()
        setConstraints()
    }
    
    func setup(){
    }
    
    func setHierarchy(){
        contentView.addSubview(numberView)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            numberView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            numberView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            numberView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            numberView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        ])
    }
}
