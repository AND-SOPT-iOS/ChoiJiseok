//
//  Seminar3CollectionViewTestController.swift
//  35-Seminar
//
//  Created by 최지석 on 10/26/24.
//

import UIKit
import SnapKit
import Then

final class Seminar3CollectionViewTestController: UIViewController {
    
    var photos: [Photo] = [
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false),
        Photo(image: UIImage(named: "toss_icon")!,
              isLiked: false)
    ]
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: UICollectionViewFlowLayout())
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        makeUI()
        setCollectionView()
    }
    
    
    private func makeUI() {
        view.addSubViews(
            collectionView
        )
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    
    private func setCollectionView() {
      let flowLayout = UICollectionViewFlowLayout()
      let itemSize = (UIScreen.main.bounds.width - 6) / 3
        
      flowLayout.itemSize = .init(width: itemSize, height: itemSize)
      flowLayout.minimumLineSpacing = 3
      flowLayout.minimumInteritemSpacing = 3

      collectionView.do {
          $0.setCollectionViewLayout(flowLayout, animated: false)
          $0.backgroundColor = .black
          $0.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
          $0.delegate = self
          $0.dataSource = self
      }
    }
}


extension Seminar3CollectionViewTestController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        cell.setData(image: photos[indexPath.row].image,
                     isLiked: photos[indexPath.row].isLiked)
        
        cell.buttonHandler = { [weak self] in
            guard let self else { return }
            self.photos[indexPath.row].isLiked = !self.photos[indexPath.row].isLiked
            self.collectionView.reloadItems(at: [indexPath])
        }
        
        return cell
    }
}


class PhotoCell: UICollectionViewCell {

    static let identifier = "PhotoCell"

    private lazy var photoImageView = UIImageView()
    
    private lazy var likeButton = UIButton()

    public var buttonHandler: (() -> ())?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    

    private func setUI() {
      [photoImageView, likeButton].forEach { addSubview($0) }
    }

    private func setLayout() {
        photoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        likeButton.snp.makeConstraints {
            $0.trailing.top.equalToSuperview()
            $0.size.equalTo(30)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        likeButton.setImage(nil, for: .normal)
        buttonHandler = nil
    }
    
    public func setData(image: UIImage?,
                        isLiked: Bool) {
        photoImageView.image = image
        likeButton.setImage(UIImage(systemName: isLiked == true ? "heart.fill" : "heart"), for: .normal)
        likeButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
    }
    
    @objc private func buttonDidTap() {
        print("Button Tapped")
        buttonHandler?()
    }
}


// MARK: - preview

#if DEBUG
import SwiftUI
struct Seminar3CollectionViewTestControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        Seminar3CollectionViewTestController()
    }
}

#Preview {
    Seminar3CollectionViewTestController()
}
#endif


// MARK: - Data


struct Photo {
  let image: UIImage
  var isLiked: Bool
}
