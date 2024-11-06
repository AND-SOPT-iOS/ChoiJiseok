//
//  AppstorePopularChartController.swift
//  35-Seminar
//
//  Created by 최지석 on 11/2/24.
//

import UIKit
import SnapKit
import Then
import Combine

final class AppstorePopularChartController: UIViewController {

    private var plpData = CurrentValueSubject<PLPData?, Never>(nil)
    
    private var plpItems: [PLPRankingItem] = []
    
    private var cancellableBag = Set<AnyCancellable>()
    
    private let popularChartTableView = UITableView().then {
        $0.register(PopularRankingCell.self, forCellReuseIdentifier: PopularRankingCell.identifier)
        $0.separatorStyle = .none
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        makeUI()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchMockData()
    }
    
    
    private func makeUI() {
        
        setupNavigationItems()
        
        view.addSubViews(
            popularChartTableView
        )
        
        popularChartTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    private func setTableView() {
        popularChartTableView.delegate = self
        popularChartTableView.dataSource = self
    }
    
    
    private func setupNavigationItems() {
        let pageTitleLabel = UILabel().then {
            $0.attributedText = .makeAttributedString(text: "인기 차트",
                                                      color: .black,
                                                      font: UIFont.systemFont(ofSize: 16, weight: .semibold))
        }
        navigationItem.titleView = pageTitleLabel
    }
    
    
    private func fetchMockData() {
        guard let url = Bundle.main.url(forResource: "plp_mock", withExtension: "json") else {
            print("JSON file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(PLPData.self, from: data)
            
            print(decodedData)
            
            plpData.send(decodedData)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    
    private func bindUI() {
        plpData
            .sink(receiveValue: { [weak self] data in
                guard let self, let data else { return }
                
                plpItems = data.freeRankingSection?.items ?? []
                
                popularChartTableView.reloadData()
            })
            .store(in: &cancellableBag)
    }
}


extension AppstorePopularChartController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plpItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularRankingCell.identifier,
                                                       for: indexPath) as? PopularRankingCell else {
            return UITableViewCell()
        }
        
        let item = plpItems[indexPath.row]
        
        cell.setUI(with: item)
        cell.showBottomLine(indexPath.row != plpItems.count - 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 아이템 탭 이벤트 핸들링 필요
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



// MARK: - preview

#if DEBUG
import SwiftUI
struct AppstorePopularChartControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        AppstorePopularChartController()
    }
}

#Preview {
    AppstorePopularChartControllerRepresentable()
}
#endif
