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
    case feature
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
    }

    private func makeUI() {
        view.backgroundColor = UIColor.systemGroupedBackground
        setTopNavigation()
        view.addSubview(contentsTableView)
        
        contentsTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setTopNavigation() {
        navigationItem.title = "계정"
    }

    private func setupTableView() {
        contentsTableView.register(PlainTableViewCell.self, forCellReuseIdentifier: PlainTableViewCell.identifier)
        contentsTableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
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
        snapshot.appendSections([.profile])
        snapshot.appendItems([.profileCell(name: nil, isLogin: false),
                              .plainCell(title: "새로운 프로필 생성하기", titleColor: .systemBlue)], toSection: .profile)
        
        snapshot.appendSections([.feature])
        snapshot.appendItems([
            .plainCellWithRightArrow(title: "내 취미 조회하기", titleColor: .black),
            .plainCellWithRightArrow(title: "다른 사람 취미 조회하기", titleColor: .black)
        ], toSection: .feature)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UITableViewDelegate
extension ServerHomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        switch item {
        case .profileCell:
            let loginViewController = LoginViewController()
            loginViewController.delegate = self
            present(loginViewController, animated: true, completion: nil)
            
        case .plainCell(let title, _) where title == "새로운 프로필 생성하기":
            let userRegisterController = UserRegisterController()
            navigationController?.pushViewController(userRegisterController, animated: true)
            
        case .plainCellWithRightArrow(let title, _) where title == "내 취미 조회하기":
            let myHobbyVC = MyHobbyViewController()
            navigationController?.pushViewController(myHobbyVC, animated: true)
            
        case .plainCellWithRightArrow(let title, _) where title == "다른 사람 취미 조회하기":
            let otherUserHobbyVC = OtherUserHobbyViewController()
            navigationController?.pushViewController(otherUserHobbyVC, animated: true)
            
        default:
            break
        }
    }
    
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


extension ServerHomeController: LoginViewControllerDelegate {
    func didLogin(userName: String) {
        var snapshot = dataSource.snapshot()
        
        let updatedProfileItem = SectionItem.profileCell(name: userName, isLogin: true)
        
        let profileSectionItems = snapshot.itemIdentifiers(inSection: .profile)
        
        snapshot.deleteItems(profileSectionItems)
        snapshot.appendItems([updatedProfileItem], toSection: .profile)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
