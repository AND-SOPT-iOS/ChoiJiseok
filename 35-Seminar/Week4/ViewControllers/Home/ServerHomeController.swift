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
    case profilePlaceholderCell
    case profileCell(name: String)
    case plainCell(tag: PlainCellTag,
                   title: String, 
                   titleColor: UIColor,
                   shouldShowArrowIcon: Bool)
}

enum PlainCellTag: Equatable {
    case logout              // 로그아웃
    case createNewProfile    // 새 프로필 생성
    case lookupMyHobby       // 내 취미 조회
    case lookupOthersHobby   // 다른 사람 취미 조회
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
        contentsTableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        contentsTableView.register(ProfilePlaceholderCell.self, forCellReuseIdentifier: ProfilePlaceholderCell.identifier)
        contentsTableView.register(PlainTableViewCell.self, forCellReuseIdentifier: PlainTableViewCell.identifier)
        contentsTableView.delegate = self
    }
    

    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<SectionType, SectionItem>(tableView: contentsTableView) { tableView, indexPath, item in
            switch item {
            // MARK: 사용자 프로필 플레이스 홀더 (비로그인)
            case .profilePlaceholderCell:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePlaceholderCell.identifier,
                                                               for: indexPath) as? ProfilePlaceholderCell else {
                    return UITableViewCell()
                }
                
                return cell
            
            // MARK: 사용자 프로필
            case .profileCell(let name):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier,
                                                               for: indexPath) as? ProfileCell else {
                    return UITableViewCell()
                }
                
                cell.setUI(name: name)
                
                return cell
            
            // MARK: 기본 셀
            case .plainCell(_, let title, let titleColor, let shouldShowArrowIcon):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PlainTableViewCell.identifier,
                                                               for: indexPath) as? PlainTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.setUI(title: title,
                           titleColor: titleColor,
                           shouldShowArrowIcon: shouldShowArrowIcon)
                
                return cell
            }
        }
    }

    
    private func initializeDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, SectionItem>()
        snapshot.appendSections([.profile])
        // 프로필
        snapshot.appendItems([
            .profilePlaceholderCell,
            .plainCell(tag: .createNewProfile,
                       title: "새로운 프로필 생성하기",
                       titleColor: .systemBlue,
                       shouldShowArrowIcon: false)
        ], toSection: .profile)
        
        // 기능
        snapshot.appendSections([.feature])
        snapshot.appendItems([
            .plainCell(tag: .lookupMyHobby,
                       title: "내 취미 조회하기",
                       titleColor: .black,
                       shouldShowArrowIcon: true),
            .plainCell(tag: .lookupOthersHobby,
                       title: "다른 사람 취미 조회하기",
                       titleColor: .black,
                       shouldShowArrowIcon: true)
        ], toSection: .feature)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}


extension ServerHomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)  // 셀 클릭 후 selected 상태 지속되지 않도록 처리
        
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        switch item {
        case .profilePlaceholderCell:
            let loginViewController = LoginViewController()
            loginViewController.delegate = self
            present(loginViewController, animated: true)
            
        case .profileCell: ()
            // TODO: 유저 정보 수정 기능 구현
            
        case .plainCell(let tag, _, _, _):
            switch tag {
            // 새 프로필 생성
            case .createNewProfile:
                let userRegisterController = UserRegisterController()
                navigationController?.pushViewController(userRegisterController, animated: true)
            // 내 취미 조회
            case .lookupMyHobby:
                let myHobbyController = MyHobbyViewController()
                navigationController?.pushViewController(myHobbyController, animated: true)
            // 다른 사람 취미 조회
            case .lookupOthersHobby:
                let otherUserHobbyController = OtherUserHobbyViewController()
                navigationController?.pushViewController(otherUserHobbyController, animated: true)
            case .logout:
                // TODO: 로그아웃 기능 구현
                showUserProfilePlaceholderSection()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return UITableView.automaticDimension
        }
        
        switch item {
        case .profileCell, .profilePlaceholderCell:
            return 80
        default:
            return 44
        }
    }
}


// MARK: User Login/Out
extension ServerHomeController: LoginViewControllerDelegate {
    func didLogin(userName: String) {
        showUserProfileSection(with: userName)
    }
    
    
    private func showUserProfileSection(with name: String) {
        var snapshot = dataSource.snapshot()
        
        let profileSectionItems = snapshot.itemIdentifiers(inSection: .profile)
        
        snapshot.deleteItems(profileSectionItems)
        snapshot.appendItems([
            .profileCell(name: name),
            .plainCell(tag: .logout,
                       title: "로그아웃",
                       titleColor: .systemBlue,
                       shouldShowArrowIcon: false)
        ], toSection: .profile)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
    private func showUserProfilePlaceholderSection() {
        var snapshot = dataSource.snapshot()
        
        let profileSectionItems = snapshot.itemIdentifiers(inSection: .profile)
        
        snapshot.deleteItems(profileSectionItems)
        snapshot.appendItems([
            .profilePlaceholderCell,
            .plainCell(tag: .createNewProfile,
                       title: "새로운 프로필 생성하기",
                       titleColor: .systemBlue,
                       shouldShowArrowIcon: false)
        ], toSection: .profile)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
