//
//  ViewController.swift
//  Bank App
//
//  Created by Egor on 29.03.2026.
//

import UIKit
import Lottie

final class OnBoardingViewController: UIViewController {
    
    // MARK: – Properties
    var router: OnBoardingRouterProtocol?
    private let slides = [
        CellModel(
            mainTitle: "Добро пожаловать в Music!",
            animationName: "",
            title: "Лучший музыкальный сервис",
            buttonTitle: "Далее",
            buttonColor: UIColor(named: "greenColor2")!
        ),
        CellModel(
            mainTitle: "Ваш проводник в мир музыки",
            animationName: "",
            title: "Слушайте миллионы хитов со всего мира",
            buttonTitle: "Начать",
            buttonColor: UIColor(named: "greenColor2")!
        ),
    ]
    
    // MARK: – Subviews
    private let layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .magenta
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()

    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        
        overrideUserInterfaceStyle = .light
    }

    deinit {
        print("OndoardingVC is deinit")
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OnBoardingCell.self, forCellWithReuseIdentifier: OnBoardingCell.reuseIdentifier)
        
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        
        setupPageControl()
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = slides.count
    }
    
}

// MARK: – UICollectionViewDataSource
extension OnBoardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.reuseIdentifier, for: indexPath) as? OnBoardingCell else { return UICollectionViewCell() }

        cell.configure(with: slides[indexPath.item])
        
        cell.delegate = self
        
        return cell
    }
}

// MARK: – UICollectionViewDelegate
extension OnBoardingViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = currentIndex
    }
}

// MARK: – UICollectionViewDelegateFlowLayout
extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

// MARK: – OnBoardingCellDelegate
extension OnBoardingViewController: OnBoardingCellDelegate {
    func buttonDidTap() {
        let currentIndex = Int(collectionView.contentOffset.x / collectionView.frame.width)
        let nextIndex = currentIndex + 1
        
        if nextIndex < slides.count {
            collectionView.scrollToItem(at: IndexPath(item: nextIndex, section: 0), at: .centeredHorizontally, animated: true)
            pageControl.currentPage = nextIndex
        } else {
            router?.openLogInViewController()
        }
    }
}
