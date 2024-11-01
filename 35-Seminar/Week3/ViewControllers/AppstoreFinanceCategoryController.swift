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
        $0.register(RecommendCell.self, 
                    forCellWithReuseIdentifier: RecommendCell.identifier)
        $0.register(EssentialCell.self, 
                    forCellWithReuseIdentifier: EssentialCell.identifier)
        $0.register(RankingCell.self,
                    forCellWithReuseIdentifier: RankingCell.identifier)
        $0.register(SectionHeaderView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: SectionHeaderView.identifier)
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
                guard let self, let data else { return }
                self.applySnapshot(with: data)
            })
            .store(in: &cancellableBag)
    }
    
    private func setDelegates() {
        
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
            
            alpData.send(decodedData)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }

    
    private func configureDataSource() {
        // dataSource 설정
        dataSource = UICollectionViewDiffableDataSource<FinanceSection, AnyHashable>(collectionView: collectionView) { collectionView, indexPath, item in
            
            guard let sectionType = FinanceSection(rawValue: indexPath.section) else {
                return UICollectionViewCell()
            }
            
            switch sectionType {
            // MARK: 추천 배너
            case .recommend:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCell.identifier,
                                                                    for: indexPath) as? RecommendCell else {
                    return UICollectionViewCell()
                }
                if let bannerSection = item as? BannerSection {
                    cell.setUI(with: bannerSection)
                }
                return cell
            // MARK: 필수 앱
            case .essential:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EssentialCell.identifier,
                                                                    for: indexPath) as? EssentialCell else {
                    return UICollectionViewCell()
                }
                if let essentialItem = item as? EssentialItem {
                    cell.setUI(with: essentialItem)
                    cell.showBottomLine((indexPath.row + 1) % 3 != 0)
                }
                return cell
            // MARK: 유료 순위
            case .paidRanking:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankingCell.identifier,
                                                              for: indexPath) as? RankingCell else {
                    return UICollectionViewCell()
                }
                if let essentialItem = item as? RankingItem {
                    cell.setUI(with: essentialItem)
                    cell.showBottomLine((indexPath.row + 1) % 3 != 0)
                }
                return cell
            // MARK: 무료 순위
            case .freeRanking:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankingCell.identifier, for: indexPath) as? RankingCell else {
                    return UICollectionViewCell()
                }
                if let freeRankingItem = item as? RankingItem {
                    cell.setCellID(freeRankingItem.id)
                    cell.setUI(with: freeRankingItem)
                    cell.showBottomLine((indexPath.row + 1) % 3 != 0)
                    cell.delegate = self
                }
                return cell

            }
        }
        
        // 헤더 등록
        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView, kind: String, indexPath: IndexPath
        ) -> UICollectionReusableView? in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return UICollectionReusableView()
            }

            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            guard section != .recommend else { return nil }

            switch section {
            // MARK: 필수 앱 헤더
            case .essential:
                guard let essentialSection = self.alpData.value?.essentialSection else { return nil }
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                    withReuseIdentifier: SectionHeaderView.identifier,
                                                                                    for: indexPath) as? SectionHeaderView
                sectionHeader?.setUI(with: essentialSection.title,
                                     description: essentialSection.description)
                return sectionHeader
            // MARK: 유료 순위 헤더
            case .paidRanking:
                guard let essentialSection = self.alpData.value?.paidRankingSection else { return nil }
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                    withReuseIdentifier: SectionHeaderView.identifier,
                                                                                    for: indexPath) as? SectionHeaderView
                sectionHeader?.setUI(with: essentialSection.title,
                                     description: essentialSection.description)
                return sectionHeader
            // MARK: 무료 순위 헤더
            case .freeRanking:
                guard let essentialSection = self.alpData.value?.freeRankingSection else { return nil }
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                    withReuseIdentifier: SectionHeaderView.identifier,
                                                                                    for: indexPath) as? SectionHeaderView
                sectionHeader?.setUI(with: essentialSection.title,
                                     description: essentialSection.description)
                sectionHeader?.delegate = self
                return sectionHeader
            default:
                return nil
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
        
        snapshot.appendSections([.paidRanking])
        if let paidRankingItems = data.paidRankingSection?.items {
            snapshot.appendItems(paidRankingItems, toSection: .paidRanking)
        }
        
        snapshot.appendSections([.freeRanking])
        if let freeRankingItems = data.freeRankingSection?.items {
            snapshot.appendItems(freeRankingItems, toSection: .freeRanking)
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
            case .paidRanking, .freeRanking:
                return self.createRankingSectionLayout()
            }
        }
    }
    
    
    func createRecommendSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(276)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(UIScreen.main.bounds.width - 30),
            heightDimension: .estimated(276)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = .init(top: 10, leading: 0, bottom: 40, trailing: 0)

        return section
    }

    
    func createEssentialSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(72)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(UIScreen.main.bounds.width - 40),
            heightDimension: .estimated(240)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: Array(repeating: item, count: 3))
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 5, leading: 20, bottom: 40, trailing: 20)
        section.interGroupSpacing = 10
        
        // Essential 섹션 헤더 추가
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    
    func createRankingSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(72)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(UIScreen.main.bounds.width - 40),
            heightDimension: .estimated(240)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: Array(repeating: item, count: 3))
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 5, leading: 20, bottom: 40, trailing: 20)
        section.interGroupSpacing = 10
        
        // Ranking 섹션 헤더 추가
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(28))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}


extension AppstoreFinanceCategoryController: SectionHeaderViewDelegate {
    func sectionHeaderViewDidTap() {
        let popularChartController = AppstorePopularChartController()
        navigationController?.pushViewController(popularChartController, animated: true)
        navigationItem.backButtonTitle = "금융"
    }
}


extension AppstoreFinanceCategoryController: RankingCellDelegate {
    func rankingCellDidTap(itemID: Int) {
        // 토스인 경우 디테일 페이지로 이동
        /// ㄴ 실제로는 제휴점 id를 뷰모델에서 들고 있다가, AppstoreDetailController로 이동할 때 전달
        ///   AppstoreDetailController 진입 시, 해당 id 값으로 PDP api 호출하여 데이터를 받아온 다음 UI에 세팅
        if itemID == 410 {
            let appstoreDetailController = AppstoreDetailController()
            navigationController?.pushViewController(appstoreDetailController, animated: true)
            navigationItem.backButtonTitle = "금융"
        }
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
