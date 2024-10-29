//
//  AppPreviewsView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then

final class AppPreviewsView: UIView {
    
    private enum CollectionViewConst {
        static let itemSize = CGSize(width: 215, height: 466)  // 캡쳐 이미지 화면 비율 (1 : 약 2.17)
        static let itemSpacing = 12.0
        static var collectionViewContentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private let containerView = UIView()
    
    private let previewInfoTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "미리 보기",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 22, weight: .bold))
    }
    
    lazy var previewImagesCollectionView = UICollectionView(frame: .zero, 
                                                            collectionViewLayout: previewImagesCollectionViewFlowLayout).then {
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.register(AppPreviewImageCollectionViewCell.self,
                    forCellWithReuseIdentifier: AppPreviewImageCollectionViewCell.identifier)
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
    
    
    // PreviewImagesCollectionView DataSource
    private var previewImages: [String] = []
    
    private var indexOfCellBeforeDragging = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
        setPreviewImagesCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUI() {
        
        addSubview(
            containerView.addSubViews(
                previewInfoTitleLabel,
                previewImagesCollectionView
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(510)
        }
        
        previewInfoTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        previewImagesCollectionView.snp.makeConstraints {
            $0.top.equalTo(previewInfoTitleLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    
    private func setPreviewImagesCollectionView() {
        previewImagesCollectionView.delegate = self
        previewImagesCollectionView.dataSource = self
    }
    
    
    public func setUI(with data: PreviewImages) {
        
        clearUI()
        
        guard let images = data.images, !images.isEmpty else { return }
        
        previewImages = images
        previewImagesCollectionView.reloadData()
    }
    
    
    private func clearUI() {
        previewImages.removeAll()
    }
    
    var currentScrollOffset: CGPoint = CGPoint(x: 0, y: 0)
}


extension AppPreviewsView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // CollectionView에서 보여줄 아이템 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.previewImages.count
    }
    
    // CollectionView 내 셀 세팅
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppPreviewImageCollectionViewCell.identifier,
                                                            for: indexPath) as? AppPreviewImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUI(imageURL: previewImages[indexPath.row])
        return cell
    }
}


extension AppPreviewsView: UICollectionViewDelegateFlowLayout {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.previewImagesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
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
//    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        currentScrollOffset = previewImagesCollectionView.contentOffset
//    }
//    
//    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        //        let layout = self.previewImagesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        //        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//        let target = targetContentOffset.pointee
//        //Current scroll distance is the distance between where the user tapped and the destination for the scrolling (If the velocity is high, this might be of big magnitude)
//        let currentScrollDistance = target.x - currentScrollOffset.x
//        //Make the value an integer between -1 and 1 (Because we don't want to scroll more than one item at a time)
//        let coefficent = Int(max(-1, min(currentScrollDistance/0.5, 1)))
//        let currentIndex = Int(round(currentScrollOffset.x/itemWidth))
//        let adjacentItemIndex = currentIndex + coefficent
//        let adjacentItemIndexFloat = CGFloat(adjacentItemIndex)
//        let adjacentItemOffsetX = adjacentItemIndexFloat * (itemWidth(scrollView) + cellSpacing)
//        targetContentOffset.pointee = CGPoint(x: adjacentItemOffsetX, y: target.y)
//    }

//    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
//                                   withVelocity velocity: CGPoint,
//                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = self.previewImagesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//        let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
//        var index: Int = Int(round(estimatedIndex))
//         
//        if velocity.x > 0 {
//          index = Int(ceil(estimatedIndex))
//        } else if velocity.x < 0 {
//          index = Int(floor(estimatedIndex))
//        }
//         
//        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing - scrollView.contentInset.left, y: .zero)
//        
//        guard let layout = previewImagesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
//            return
//        }
//        
//        let contentLeftInset = scrollView.contentInset.left
//        let cellWithSpacing = layout.itemSize.width + layout.minimumLineSpacing
//        
//        let index = (targetContentOffset.pointee.x + contentLeftInset) / cellWithSpacing
//        let roundedIndex: CGFloat = round(index)
//
//        let adjustOffsetX = roundedIndex * cellWithSpacing - contentLeftInset
//        let adjustCGPoint = CGPoint(x: adjustOffsetX, y: scrollView.contentInset.top)
//
//        if scrollView.contentOffset.x < targetContentOffset.pointee.x {
//            // 왼쪽 방향으로 이동 - 새 컨텐츠 방향
//            if scrollView.contentOffset.x > adjustOffsetX {
//                targetContentOffset.pointee = scrollView.contentOffset
//                scrollView.setContentOffset(adjustCGPoint, animated: true)
//            } else {
//                targetContentOffset.pointee = adjustCGPoint
//            }
//        } else {
//            // 오른쪽 방향으로 이동 - 이전 컨텐츠 방향
//            if scrollView.contentOffset.x < adjustOffsetX {
//                targetContentOffset.pointee = scrollView.contentOffset
//                scrollView.setContentOffset(adjustCGPoint, animated: true)
//            } else {
//                targetContentOffset.pointee = adjustCGPoint
//            }
//        }
//        
//        // item의 사이즈와 item 간의 간격 사이즈를 구해서 하나의 item 크기로 설정.
//        let layout = self.previewImagesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//        
//        // targetContentOff을 이용하여 x좌표가 얼마나 이동했는지 확인
//        // 이동한 x좌표 값과 item의 크기를 비교하여 몇 페이징이 될 것인지 값 설정
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
//        var roundedIndex = round(index)
//        
//        // scrollView, targetContentOffset의 좌표 값으로 스크롤 방향을 알 수 있다.
//        // index를 반올림하여 사용하면 item의 절반 사이즈만큼 스크롤을 해야 페이징이 된다.
//        // 스크로로 방향을 체크하여 올림,내림을 사용하면 좀 더 자연스러운 페이징 효과를 낼 수 있다.
//        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
//            roundedIndex = floor(index)
//        } else {
//            roundedIndex = ceil(index)
//        }
//        
//        // 위 코드를 통해 페이징 될 좌표값을 targetContentOffset에 대입하면 된다.
//        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
//        targetContentOffset.pointee = offset
//        
//        print("--------------------------Scroll---------------------------")
//        print("offset.x + scrollView.contentInset.left : \(offset.x + scrollView.contentInset.left)")
//        print("index: \(index)")
//        print("roundedIndex: \(roundedIndex)")
//        print("roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left: \(roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left)")
//        print("velocity : \(velocity.x)")
//  }
}
