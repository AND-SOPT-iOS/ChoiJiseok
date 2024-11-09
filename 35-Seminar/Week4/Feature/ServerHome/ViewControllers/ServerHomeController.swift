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
    case logout
}

enum SectionItem: Hashable, Equatable {
    case profilePlaceholderCell
    case profileCell(name: String)
    case plainCell(tag: PlainCellTag,
                   title: String, 
                   titleColor: UIColor,
                   subTitle: String? = nil,
                   shouldShowArrowIcon: Bool)
}

enum PlainCellTag: Equatable {
    case logout              // 로그아웃
    case createNewProfile    // 새 프로필 생성
    case userHobby           // 사용자 취미
    case lookupHobby   // 다른 사용자 취미 조회
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
            case .plainCell(_, let title, let titleColor, let subTitle, let shouldShowArrowIcon):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PlainTableViewCell.identifier,
                                                               for: indexPath) as? PlainTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.setUI(title: title,
                           titleColor: titleColor,
                           subTitle: subTitle,
                           shouldShowArrowIcon: shouldShowArrowIcon)
                
                return cell
            }
        }
    }

    
    private func initializeDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, SectionItem>()

        // MARK: 프로필
        snapshot.appendSections([.profile])
        snapshot.appendItems([
            .profilePlaceholderCell,
            .plainCell(tag: .createNewProfile,
                       title: "새로운 프로필 생성하기",
                       titleColor: .systemBlue,
                       shouldShowArrowIcon: false)
        ], toSection: .profile)
        
        // MARK: 기능
        snapshot.appendSections([.feature])
        snapshot.appendItems([
            .plainCell(tag: .lookupHobby,
                       title: "취미 조회하기",
                       titleColor: .black,
                       shouldShowArrowIcon: true)
        ], toSection: .feature)
        
        // MARK: 로그아웃
        snapshot.appendSections([.logout])
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}


extension ServerHomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)  // 셀 클릭 후 selected 상태 지속되지 않도록 처리
        
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        switch item {
        case .profilePlaceholderCell:
            let userLoginController = UserLoginController().then {
                $0.delegate = self
            }
            navigationController?.present(userLoginController, animated: true)
            
        case .profileCell(let name):
            let userInfoEditController = UserInfoEditController().then {
                $0.delegate = self
                $0.setUI(name: name)
            }
            navigationController?.present(userInfoEditController, animated: true)
            
        case .plainCell(let tag, _, _, _, _):
            switch tag {
            // 새 프로필 생성
            case .createNewProfile:
                let userRegisterController = UserRegisterController()
                navigationController?.present(userRegisterController, animated: true)
            // 내 취미 조회
            case .userHobby: ()
            // 다른 사람 취미 조회
            case .lookupHobby:
                let userHobbyLookUpController = UserHobbyLookUpController()
                navigationController?.present(userHobbyLookUpController, animated: true)
            case .logout:
                TokenManager.shared.clearTokens()
                showNonLoginDefaultLayout()
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


// MARK: Section Layout
extension ServerHomeController {
    private func showLoginDefaultLayout(with name: String) {
        
        var snapshot = dataSource.snapshot()
        
        // 프로필 영역
        let profileSectionItems = snapshot.itemIdentifiers(inSection: .profile)
        snapshot.deleteItems(profileSectionItems)
        snapshot.appendItems([
            .profileCell(name: name),
        ], toSection: .profile)
                
        // 기능 영역
        let featureSectionItems = snapshot.itemIdentifiers(inSection: .feature)
        snapshot.deleteItems(featureSectionItems)
        snapshot.appendItems([
            .plainCell(tag: .lookupHobby,
                       title: "취미 조회하기",
                       titleColor: .black,
                       shouldShowArrowIcon: true)
        ], toSection: .feature)
        
        // 로그아웃 영역 (추가)
        snapshot.appendItems([
            .plainCell(tag: .logout,
                       title: "로그아웃",
                       titleColor: .systemBlue,
                       shouldShowArrowIcon: false),
        ], toSection: .logout)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
    private func showNonLoginDefaultLayout() {
        
        var snapshot = dataSource.snapshot()
        
        // 프로필 영역
        let profileSectionItems = snapshot.itemIdentifiers(inSection: .profile)
        snapshot.deleteItems(profileSectionItems)
        snapshot.appendItems([
            .profilePlaceholderCell,
            .plainCell(tag: .createNewProfile,
                       title: "새로운 프로필 생성하기",
                       titleColor: .systemBlue,
                       shouldShowArrowIcon: false)
        ], toSection: .profile)
        
        // 기능 영역
        let featureSectionItems = snapshot.itemIdentifiers(inSection: .feature)
        snapshot.deleteItems(featureSectionItems)
        snapshot.appendItems([
            .plainCell(tag: .lookupHobby,
                       title: "취미 조회하기",
                       titleColor: .black,
                       shouldShowArrowIcon: true)
        ], toSection: .feature)
        
        // 로그아웃 영역 (제거)
        let logoutSectionItems = snapshot.itemIdentifiers(inSection: .logout)
        snapshot.deleteItems(logoutSectionItems)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    

    private func showUserHobbyCell(with hobby: String) {
        var snapshot = dataSource.snapshot()
        
        let featureSectionItems = snapshot.itemIdentifiers(inSection: .feature)
        snapshot.deleteItems(featureSectionItems)
        snapshot.appendItems([
            .plainCell(tag: .userHobby,
                       title: "내 취미",
                       titleColor: .black,
                       subTitle: hobby,
                       shouldShowArrowIcon: false),
            .plainCell(tag: .lookupHobby,
                       title: "사용자 취미 조회",
                       titleColor: .black,
                       shouldShowArrowIcon: true)
        ], toSection: .feature)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}


// MARK: Login
extension ServerHomeController: UserLoginControllerDelegate {
    func didLogin(username: String) {
        showLoginDefaultLayout(with: username)
        
        // 사용자 취미 조회
        UserService.shared.getMyHobby { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let hobby):
                showUserHobbyCell(with: hobby)
            case .failure(let error):
                showAlert(title: "취미 조회 실패", message: error.errorMessage)
            }
            
        }
    }
}


// MARK: UserInfo Edit
extension ServerHomeController: UserInfoEditControllerDelegate {
    func didEditUserInfo(newHobby: String) {
        showUserHobbyCell(with: newHobby)
    }
}
