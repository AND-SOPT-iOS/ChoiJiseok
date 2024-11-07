//
//  ServerHomeController.swift
//  35-Seminar
//
//  Created by 최지석 on 11/2/24.
//

//
//  ServerHomeController.swift
//  35-Seminar
//
//  Created by 최지석 on 11/2/24.
//

import UIKit
import SnapKit

enum SectionType: Int, CaseIterable, Hashable {
    case profile
    case control
}

enum SectionItem: Hashable, Equatable {
    case profileCell(name: String?, isLogin: Bool)
    case plainCell(title: String, titleColor: UIColor)
    case plainCellWithRightArrow(title: String, titleColor: UIColor)
}


class ServerHomeController: UIViewController {
    
    private let contentsTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private var dataSource: UITableViewDiffableDataSource<SectionType, SectionItem>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        setupTableView()
        setupDataSource()
        initializeDataSource()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.updateDataSource()
        }
    }
    
    private func makeUI() {
        view.addSubViews(
            contentsTableView
        )
        
        contentsTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        contentsTableView.register(PlainTableViewCell.self, forCellReuseIdentifier: PlainTableViewCell.identifier)
        contentsTableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        contentsTableView.backgroundColor = UIColor.systemGroupedBackground
        contentsTableView.delegate = self
    }
    
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<SectionType, SectionItem>(tableView: contentsTableView) { tableView, indexPath, item in
            switch item {
            case .profileCell(let name, let isLogin):
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
                if isLogin {
                    cell.showUserProfile(name: name)
                } else {
                    cell.showPlaceholder()
                }
                return cell
            case .plainCell(let title, let titleColor):
                let cell = tableView.dequeueReusableCell(withIdentifier: PlainTableViewCell.identifier, for: indexPath) as! PlainTableViewCell
                cell.setData(title: title, titleColor: titleColor, shouldShowArrowIcon: false)
                return cell
            case .plainCellWithRightArrow(let title, let titleColor):
                let cell = tableView.dequeueReusableCell(withIdentifier: PlainTableViewCell.identifier, for: indexPath) as! PlainTableViewCell
                cell.setData(title: title, titleColor: titleColor, shouldShowArrowIcon: true)
                return cell
            }
        }
    }

    
    private func initializeDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, SectionItem>()
        
        // Profile Section
        snapshot.appendSections([.profile])
        snapshot.appendItems([.profileCell(name: nil, isLogin: false),
                              .plainCell(title: "새로운 프로필 생성하기", titleColor: .systemBlue)], toSection: .profile)
        
        // Control Section
        snapshot.appendSections([.control])
        snapshot.appendItems([
            .plainCellWithRightArrow(title: "내 취미 조회하기", titleColor: .black),
            .plainCellWithRightArrow(title: "다른 사람 취미 조회하기", titleColor: .black),
        ], toSection: .control)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
    private func updateDataSource() {
        var currentSnapshot = dataSource.snapshot()
        
        let updatedProfileItem = SectionItem.profileCell(name: "최지석", isLogin: true)
        
        let profileSectionItems = currentSnapshot.itemIdentifiers(inSection: .profile)
        
        currentSnapshot.deleteItems(profileSectionItems)
        currentSnapshot.appendItems([updatedProfileItem], toSection: .profile)
        
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }

}


// MARK: - UITableViewDelegate
extension ServerHomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return UITableView.automaticDimension
        }
        
        switch item {
        case .profileCell:
            return 80
        default:
            return 44
        }
    }
}
