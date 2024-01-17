//
//  TambolaViewController.swift
//  Tamblola
//
//  Created by Yash Bedi on 14/01/24.
//

import UIKit

final class TambolaViewController: UIViewController {

    private let presenter: TambolaPresenter
    
    private var topLabelConstraint: NSLayoutConstraint?
    
    init(presenter: TambolaPresenter){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start Tambola", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button.addTarget(self, action: #selector(gameStartButtonTapped(_:)), for: .touchUpInside)
        button.backgroundColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()
    
    private let gameStartView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemCyan
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var generatedNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 180)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private lazy var generateNextTambolaNumerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Generate next number", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        button.addTarget(self, action: #selector(generateNextTambolaNumber(_:)), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabelConstraint == nil ? () : customiseLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.blue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(pushTambolaGridVC))

        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pinFirstNumber()
    }
    
    func gameHasStarted() {
        startButton.removeFromSuperview()
        gameStartView.removeFromSuperview()
    }
    
    func customiseLabel() {
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            
            topLabelConstraint?.isActive = false
            /// This is Portrait
            topLabelConstraint = generatedNumberLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
            topLabelConstraint?.isActive = true
            
            generatedNumberLabel.font = UIFont.boldSystemFont(ofSize: 180)
            generatedNumberLabel.textColor = .white
            view.layoutIfNeeded()
        }else{
            
            topLabelConstraint?.isActive = false
            /// This is Landscape
            topLabelConstraint = generatedNumberLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
            topLabelConstraint?.isActive = true
            
            generatedNumberLabel.font = UIFont.boldSystemFont(ofSize: 100)
            generatedNumberLabel.textColor = .white
            view.layoutIfNeeded()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        topLabelConstraint == nil ? () : customiseLabel()
    }
}

private extension TambolaViewController {
    
    func commonInit(){
        setup()
        setHierarchy()
        setConstraints()
    }
    
    func setup(){
        view.backgroundColor = .systemIndigo
        title = "Tambola"
    }
    
    func setHierarchy(){
        view.addSubview(generatedNumberLabel)
        view.addSubview(generateNextTambolaNumerButton)
        addGameStartSubViews()
    }
    
    func setConstraints(){
        topLabelConstraint = generatedNumberLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        topLabelConstraint?.isActive = true
        NSLayoutConstraint.activate([
            generatedNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generatedNumberLabel.heightAnchor.constraint(equalToConstant: 250),
            generatedNumberLabel.widthAnchor.constraint(equalToConstant: 250),
        ])
        
        NSLayoutConstraint.activate([
            generateNextTambolaNumerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            generateNextTambolaNumerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            generateNextTambolaNumerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        addConstraintsForGameStartSubView()
    }
    
    func addGameStartSubViews(){
        view.addSubview(gameStartView)
        gameStartView.addSubview(startButton)
    }
    
    func addConstraintsForGameStartSubView(){
        NSLayoutConstraint.activate([
            gameStartView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            gameStartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            gameStartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            gameStartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    func pinFirstNumber(){
        generatedNumberLabel.text = "\(presenter.lastGeneratedNum)"
    }
}


private extension TambolaViewController {
    
    @objc
    func gameStartButtonTapped(_ sender: UIButton){
        gameHasStarted()
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    }
    
    @objc
    func generateNextTambolaNumber(_ sender: UIButton) {
        let allNumbersAreCalled = presenter.mapForAlreadyGeneratedNums.values.allSatisfy{ $0 == true }
        if allNumbersAreCalled {
            addGameStartSubViews()
            addConstraintsForGameStartSubView()
            presenter.resetGame()
            pinFirstNumber()
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            return
        }
        generatedNumberLabel.text = "\(presenter.getNextTambolaNumber())"
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    @objc
    func pushTambolaGridVC(_ sender: Any){
        navigationController?.pushViewController(TambolaGridViewController(presenter: presenter), animated: true)
    }
}
