//
//  AppRatingAndReviewsView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then


public protocol AppRatingAndReviewsViewDelegate: AnyObject {
    func ratingAndReviewsButtonDidTap()
}

final class AppRatingAndReviewsView: UIView {
    
    private enum CollectionViewConst {
        static let itemSize = CGSize(width: UIScreen.main.bounds.size.width - 40, height: 200)
        static let itemSpacing = 12.0
        static var collectionViewContentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    weak var delegate: AppRatingAndReviewsViewDelegate?
    
    private let containerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 12
        $0.insetsLayoutMarginsFromSafeArea = false
        $0.isLayoutMarginsRelativeArrangement = true
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 22, trailing: 0)
    }
    
    private let ratingContainerView = UIView()
    
    private let ratingAndReviewsButton = UIButton().then {
        
        var config = UIButton.Configuration.plain()
        // 타이틀
        config.attributedTitle = AttributedString(.makeAttributedString(text: "평가 및 리뷰",
                                                                        color: .black,
                                                                        font: UIFont.systemFont(ofSize: 22,
                                                                                                weight: .black)))
        // 이미지
        config.image = UIImage(systemName: "chevron.right")
        config.imagePadding = 2
        config.imagePlacement = .trailing
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 14,
                                                                                  weight: .heavy)
        config.baseForegroundColor = .gray
        // 상하좌우 패딩
        config.contentInsets = .zero
        
        $0.configuration = config
    }
    
    private let averageRatingLabel = UILabel()
    
    private let ratingAndReviewsStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .trailing
        $0.spacing = 4
    }
    
    private let ratingAndReviewsStarsView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private let ratingAndReviewsStarsBackgroundView = UIView().then {
        $0.backgroundColor = .black
    }
    
    private let ratingAndReviewsStarsForegroundImageView = UIImageView().then {
        $0.image = UIImage(named: "stars_container")
        $0.contentMode = .scaleAspectFit
    }
    
    private let ratingAndReviewsCountLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "8.4만개의 평가",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 17, weight: .medium))
    }
    
    private let reviewContainerView = UIView()
    
    private let mostHelpfulReviewTitleInfoLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "가장 도움이 되는 리뷰",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 18, weight: .semibold))
    }
    
    lazy var userReviewsCollectionView = UICollectionView(frame: .zero,
                                                          collectionViewLayout: previewImagesCollectionViewFlowLayout).then {
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.backgroundColor = .clear
        $0.clipsToBounds = false
        $0.register(UserReviewCell.self,
                    forCellWithReuseIdentifier: UserReviewCell.identifier)
        $0.isPagingEnabled = false                  // 한 페이지의 넓이를 조절 할 수 없기 때문에 scrollViewWillEndDragging을 사용하여 구현
        $0.contentInsetAdjustmentBehavior = .never  // 내부적으로 safe area에 의해 가려지는 것을 방지하기 위해서 자동으로 inset 조정해 주는 것을 비활성화
        $0.contentInset = CollectionViewConst.collectionViewContentInset
        $0.decelerationRate = .fast                 // 스크롤이 빠르게 되도록 설정 (페이징 애니메이션같이 보이게 하기 위함)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let previewImagesCollectionViewFlowLayout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .horizontal
       layout.itemSize = CollectionViewConst.itemSize
       layout.minimumLineSpacing = CollectionViewConst.itemSpacing
       layout.minimumInteritemSpacing = 0
       return layout
     }()
    
    private var reviews: [UserReview] = []
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
        bindAction()
        setCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUI() {
        
        addSubview(
            containerStackView.addArrangedSubViews(
                // 평점 컨테이너
                ratingContainerView.addSubViews(
                    ratingAndReviewsButton,
                    averageRatingLabel,
                    ratingAndReviewsStackView.addArrangedSubViews(
                        ratingAndReviewsStarsView.addSubViews(
                            ratingAndReviewsStarsBackgroundView,
                            ratingAndReviewsStarsForegroundImageView
                        ),
                        ratingAndReviewsCountLabel
                    )
                ),
                // 사용자 리뷰 컨테이너
                reviewContainerView.addSubViews(
                    mostHelpfulReviewTitleInfoLabel,
                    userReviewsCollectionView
                )
            )
        )
        
        // MARK: - 평점 컨테이너
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        ratingAndReviewsButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
        }
        
        averageRatingLabel.snp.makeConstraints {
            $0.top.equalTo(ratingAndReviewsButton.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        
        ratingAndReviewsStackView.snp.makeConstraints {
            $0.right.equalToSuperview().inset(20)
            $0.centerY.equalTo(averageRatingLabel.snp.centerY)
        }
        
        ratingAndReviewsStarsView.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(24)
        }

        ratingAndReviewsStarsBackgroundView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0)
        }
        
        ratingAndReviewsStarsForegroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // MARK: - 사용자 리뷰 컨테이너
        mostHelpfulReviewTitleInfoLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
        }
        
        userReviewsCollectionView.snp.makeConstraints {
            $0.top.equalTo(mostHelpfulReviewTitleInfoLabel.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
    
    
    public func setUI(with data: RatingAndReviews) {
        
        clearUI()
        
        guard let averageRating = data.averageRating,
              let maxRating = data.maxRating,
              let totalRating = data.totalReviews else { return }
                
        // 평균 점수 레이블 세팅
        averageRatingLabel.attributedText = .makeAttributedString(text: String(averageRating),
                                                                  color: .black,
                                                                  font: UIFont.systemFont(ofSize: 64, weight: .bold))

        // 별점 아이콘 세팅
        ratingAndReviewsStarsBackgroundView.snp.remakeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(averageRating / maxRating)
        }
              
        // 총 평가 갯수 레이블 세팅
        let totalCountString = NumberFormatter.formatToReviewCountString(totalRating)
        ratingAndReviewsCountLabel.attributedText = .makeAttributedString(text: "\(totalCountString)개의 평가",
                                                                          color: .gray,
                                                                          font: UIFont.systemFont(ofSize: 17, weight: .medium))
        
        // 사용자 리뷰 세팅
        guard let userReviews = data.mostHelpfulReviews, !userReviews.isEmpty else { return }
        
        reviews = userReviews
        userReviewsCollectionView.reloadData()

        reviewContainerView.isHidden = false
    }
    
    
    private func clearUI() {
        averageRatingLabel.attributedText = nil
        ratingAndReviewsCountLabel.attributedText = nil
        
        ratingAndReviewsStarsBackgroundView.snp.remakeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0)
        }
        
        reviews = []
        reviewContainerView.isHidden = true
    }
    
    
    private func bindAction() {
        ratingAndReviewsButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            delegate?.ratingAndReviewsButtonDidTap()
        }), for: .touchUpInside)
    }
    
    
    private func setCollectionView() {
        userReviewsCollectionView.dataSource = self
        userReviewsCollectionView.delegate = self
    }
}


extension AppRatingAndReviewsView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserReviewCell.identifier,
                                                            for: indexPath) as? UserReviewCell else {
            return UICollectionViewCell()
        }
        cell.setUI(with: reviews[indexPath.row])
        return cell
    }
}



extension AppRatingAndReviewsView: UICollectionViewDelegateFlowLayout {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.userReviewsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
        var index: Int = Int(round(estimatedIndex))
        
        if velocity.x > 0 {
            index = Int(ceil(estimatedIndex))
        } else if velocity.x < 0 {
            index = Int(floor(estimatedIndex))
        }
        
        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing - scrollView.contentInset.left, y: .zero)
    }
}
