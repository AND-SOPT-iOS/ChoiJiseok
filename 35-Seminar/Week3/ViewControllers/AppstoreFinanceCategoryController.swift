//
//  AppstoreFinanceCategoryController.swift
//  35-Seminar
//
//  Created by 최지석 on 11/1/24.
//

import UIKit
import SnapKit
import Then
import Combine

final class AppstoreFinanceCategoryController: UIViewController {

    private var alpData = CurrentValueSubject<ALPData?, Never>(nil)
    private var cancellableBag = Set<AnyCancellable>()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout()).then {
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        $0.register(RecommendCell.self, forCellWithReuseIdentifier: RecommendCell.identifier)
        $0.register(EssentialCell.self, forCellWithReuseIdentifier: EssentialCell.identifier)
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<FinanceSection, AnyHashable>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        configureDataSource()
        bindUI()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMockData()
    }
    
    deinit {
        print("Detail ViewController Deinit")
    }
    
    private func makeUI() {
        view.backgroundColor = .white
        setupNavigationItems()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func setupNavigationItems() {
        let pageTitleLabel = UILabel().then {
            $0.attributedText = .makeAttributedString(text: "금융",
                                                      color: .black,
                                                      font: UIFont.systemFont(ofSize: 16, weight: .semibold))
        }
        navigationItem.titleView = pageTitleLabel
    }
    
    private func bindUI() {
        alpData
            .sink(receiveValue: { [weak self] data in
                guard let self = self, let data = data else { return }
                self.applySnapshot(with: data)
            })
            .store(in: &cancellableBag)
    }
    
    private func setDelegates() {
        // Set delegates if needed
    }
    
    private func fetchMockData() {
        guard let url = Bundle.main.url(forResource: "alp_mock", withExtension: "json") else {
            print("JSON file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(ALPData.self, from: data)
            print(decodedData)
            alpData.send(decodedData)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }

    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<FinanceSection, AnyHashable>(collectionView: collectionView) { collectionView, indexPath, item in
            let sectionType = FinanceSection(rawValue: indexPath.section)!
            switch sectionType {
            case .recommend:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCell.identifier, for: indexPath) as! RecommendCell
                if let bannerSection = item as? BannerSection {
                    cell.setUI(with: bannerSection)
                }
                return cell
            case .essential:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EssentialCell.identifier, for: indexPath) as! EssentialCell
                if let essentialItem = item as? EssentialItem {
                    cell.setUI(with: essentialItem)
                }
                return cell
            }
        }
    }

    private func applySnapshot(with data: ALPData) {
        var snapshot = NSDiffableDataSourceSnapshot<FinanceSection, AnyHashable>()
        
        snapshot.appendSections([.recommend])
        if let bannerItems = data.bannerSection {
            snapshot.appendItems(bannerItems, toSection: .recommend)
        }
        
        snapshot.appendSections([.essential])
        if let essentialItems = data.essentialSection?.items {
            snapshot.appendItems(essentialItems, toSection: .essential)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let sectionType = FinanceSection(rawValue: sectionIndex) else { return nil }
            switch sectionType {
            case .recommend:
                return self.createRecommendSectionLayout()
            case .essential:
                return self.createEssentialSectionLayout()
            }
        }
    }
    
    
    func createRecommendSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(300)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(UIScreen.main.bounds.width - 30),
            heightDimension: .estimated(300)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return section
    }
    
    
    func createEssentialSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(70)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(UIScreen.main.bounds.width - 40), // 전체 너비에서 좌우 여백을 고려한 너비
            heightDimension: .estimated(210)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: Array(repeating: item, count: 3))
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0) // 그룹 내부에 따로 여백을 주지 않음
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20) // 양쪽 끝 여백 설정
        section.interGroupSpacing = 10 // 그룹 간 10px 간격 설정

        return section
    }
}



// MARK: - preview

#if DEBUG
import SwiftUI
struct AppstoreFinanceCategoryControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        AppstoreFinanceCategoryController()
    }
}

#Preview {
    AppstoreFinanceCategoryControllerRepresentable()
}
#endif
