//
//  Seminar3TestController.swift
//  35-Seminar
//
//  Created by 최지석 on 10/26/24.
//

import UIKit
import SnapKit
import Then

final class Seminar3TestController: UIViewController {
    
    let sampleApps: [App] = [
        App(
            iconImage: UIImage(systemName: "soccerball"),
            ranking: 1,
            title: "YouTube",
            subtitle: "동영상과 음악을 스트리밍하세요",
            category: "엔터테인먼트",
            downloadState: .installed
        ),
        App(
            iconImage: UIImage(systemName: "soccerball"),
            ranking: 2,
            title: "Netflix",
            subtitle: "영화와 TV 프로그램 시청",
            category: "엔터테인먼트",
            downloadState: .update
        ),
        App(
            iconImage: UIImage(systemName: "soccerball"),
            ranking: 3,
            title: "카카오톡",
            subtitle: "무료 메시징과 통화",
            category: "소셜 네트워킹",
            downloadState: .installed
        ),
        App(
            iconImage: UIImage(systemName: "soccerball"),
            ranking: 4,
            title: "Instagram",
            subtitle: "사진과 동영상 공유",
            category: "소셜 네트워킹",
            downloadState: .download
        ),
        App(
            iconImage: UIImage(systemName: "soccerball"),
            ranking: 5,
            title: "Twitter",
            subtitle: "실시간 뉴스와 대화",
            category: "소셜 네트워킹",
            downloadState: .redownload
        ),
        App(
            iconImage: UIImage(systemName: "soccerball"),
            ranking: 6,
            title: "Spotify",
            subtitle: "음악 스트리밍 서비스",
            category: "음악",
            downloadState: .download
        ),
        App(
            iconImage: UIImage(systemName: "soccerball"),
            ranking: 7,
            title: "쿠팡",
            subtitle: "로켓배송",
            category: "쇼핑",
            downloadState: .update
        ),
        App(
            iconImage: UIImage(systemName: "soccerball")!,
            ranking: 8,
            title: "네이버",
            subtitle: "검색과 뉴스",
            category: "유틸리티",
            downloadState: .installed
        ),
        App(
            iconImage: UIImage(systemName: "soccerball"),
            ranking: 9,
            title: "토스",
            subtitle: "간편 송금과 결제",
            category: "금융",
            downloadState: .redownload
        ),
        App(
            iconImage: UIImage(systemName: "soccerball"),
            ranking: 10,
            title: "배달의민족",
            subtitle: "음식 배달 서비스",
            category: "푸드",
            downloadState: .installed
        ),
        App(
            iconImage: UIImage(systemName: "soccerball"),
            ranking: 11,
            title: "Discord",
            subtitle: "게이머를 위한 채팅",
            category: "소셜 네트워킹",
            downloadState: .download
        ),
        App(
            iconImage: UIImage(systemName: "soccerball"),
            ranking: 12,
            title: "Google",
            subtitle: "검색과 클라우드 서비스",
            category: "유틸리티",
            downloadState: .update
        ),
        App(
            iconImage: UIImage(systemName: "soccerball"),
            ranking: 13,
            title: "Facebook",
            subtitle: "친구와 소통하기",
            category: "소셜 네트워킹",
            downloadState: .redownload
        ),
        App(
            iconImage: UIImage(systemName: "soccerball"),
            ranking: 14,
            title: "LINE",
            subtitle: "무료 메시지와 통화",
            category: "소셜 네트워킹",
            downloadState: .installed
        ),
        App(
            iconImage: UIImage(systemName: "soccerball"),
            ranking: 15,
            title: "Outlook",
            subtitle: "이메일과 캘린더",
            category: "생산성",
            downloadState: .download
        )
    ]

    
    private let tableView = UITableView().then {
        $0.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        setTableView()
    }
    
    
    private func makeUI() {
        view.addSubViews(
            tableView
        )
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension Seminar3TestController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleApps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
            
        let item = sampleApps[indexPath.row]
        
        cell.setData(iconImage: item.iconImage,
                     ranking: item.ranking,
                     title: item.title,
                     subtitle: item.subtitle,
                     downloadState: item.downloadState)
        
        return cell
    }
}

final class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    private let containerView = UIView()
    
    private let appIconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Week2ColorSet.logoImageBorderColor.cgColor
    }
    
    private let titleStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 2
        $0.alignment = .leading
    }
    
    private let indexLabel = UILabel()
    
    private let titleLabel = UILabel()
    
    private let descriptionLabel = UILabel()
    
    private let downloadButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBlue
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15)
        $0.configuration = config
        
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUI() {
        addSubViews(
            containerView.addSubViews(
                appIconImageView,
                indexLabel,
                titleStackView.addArrangedSubViews(
                    titleLabel,
                    descriptionLabel
                ),
                downloadButton
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        appIconImageView.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview().inset(10)
            $0.size.equalTo(56)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(32)
        }
        
        titleStackView.snp.makeConstraints {
            $0.left.equalTo(appIconImageView.snp.right).offset(40)
            $0.centerY.equalToSuperview()
            $0.right.equalTo(downloadButton.snp.left).offset(-10)
        }
        
        indexLabel.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.top)
            $0.right.equalTo(titleStackView.snp.left)
            $0.width.equalTo(25)
        }
    }
    
    
    public func setData(iconImage: UIImage?,
                        ranking: Int?,
                        title: String?,
                        subtitle: String?,
                        downloadState: DownloadState) {
        if let iconImage {
            appIconImageView.image = iconImage
        }
        
        if let ranking {
            indexLabel.attributedText = .makeAttributedString(text: String(ranking),
                                                              color: .white,
                                                              font: UIFont.systemFont(ofSize: 16, weight: .medium))
        }
        
        if let title {
            titleLabel.attributedText = .makeAttributedString(text: title,
                                                              color: .white,
                                                              font: UIFont.systemFont(ofSize: 16, weight: .medium))
        }
        
        if let subtitle {
            descriptionLabel.attributedText = .makeAttributedString(text: subtitle,
                                                                    color: .white,
                                                                    font: UIFont.systemFont(ofSize: 15,
                                                                                            weight: .medium))
        }
        
        downloadButton.setAttributedTitle(.makeAttributedString(text: downloadState.rawValue,
                                                                color: .white,
                                                                font: UIFont.systemFont(ofSize: 15, weight: .semibold)),
                                          for: .normal)
    }
}


// MARK: - preview

#if DEBUG
import SwiftUI
struct Seminar3TestControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        Seminar3TestController()
    }
}

#Preview {
    Seminar3TestControllerRepresentable()
}
#endif


// MARK: - Data

struct App {
    let iconImage: UIImage?
    let ranking: Int?
    let title: String?
    let subtitle: String?
    let category: String?
    let downloadState: DownloadState
}


enum DownloadState: String {
    case installed = "열기"
    case download = "받기"
    case redownload = "다시 받기"
    case update = "업데이트"
}
