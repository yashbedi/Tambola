//
//  TambolaGridViewController.swift
//  Tamblola
//
//  Created by Yash Bedi on 14/01/24.
//

import UIKit

final class TambolaGridViewController: UIViewController {

    private let presenter: TambolaPresenter
    
    init(presenter: TambolaPresenter){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionViewForCalledOutNumbers: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize = CGSize(width: 32, height: 32)
//        layout.minimumInteritemSpacing = 0
//        layout.itemSize = CGSize(width: 32, height: 32)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isScrollEnabled = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension TambolaGridViewController {
    
    func commonInit(){
        setup()
        setHierarchy()
        setConstraints()
    }
    
    func setup(){
        view.backgroundColor = .systemIndigo
        collectionViewForCalledOutNumbers.register(TambolaNumberCell.self, forCellWithReuseIdentifier: Constants.kCollectionViewCell)
        collectionViewForCalledOutNumbers.dataSource = self
        collectionViewForCalledOutNumbers.delegate = self
    }
    
    func setHierarchy(){
        view.addSubview(collectionViewForCalledOutNumbers)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            collectionViewForCalledOutNumbers.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            collectionViewForCalledOutNumbers.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionViewForCalledOutNumbers.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionViewForCalledOutNumbers.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
}


extension TambolaGridViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.minTambolaNum
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.dataSourceForGrid.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kCollectionViewCell, for: indexPath) as? TambolaNumberCell else {
            return UICollectionViewCell()
        }
        cell.initCellWith(presenter.dataSourceForGrid[indexPath.row])
        if let calledNumber = presenter.mapForAlreadyGeneratedNums[indexPath.row+1], calledNumber == true {
            cell.markGeneratedNumberAsSelected()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 28, height: 28)
    }
}
