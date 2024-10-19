//
//  AppstoreDetailController.swift
//  35-Seminar
//
//  Created by 최지석 on 10/12/24.
//

import Foundation
import UIKit
import SnapKit
import Then

final class AppstoreDetailController: UIViewController {
    
    private let containerScrollView = UIScrollView()
    
    private let containerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
    }
    
    private let appTitleInfoView = AppTitleInfoView()
    
    private let appInfoHorizontalSwipeContainerView = UIView()
    
    private let appInfoHorizontalSwipeStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.addTopBorder(color: .lightGray, width: 1)
        $0.addBottomBorder(color: .lightGray, width: 1)
    }
    
    private let ratingView = UIStackView().then {
        $0.distribution = .fillProportionally
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 8
        $0.addRightBorder(color: .lightGray, width: 1, multiplier: 0.4)
    }
    
    private let ratingCountLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "8.4만개의 평가",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 12, weight: .light))
    }
    
    private let ratingScoreLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "4.4",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 22, weight: .semibold))
    }
    
    private let ratingStarsView = UIView()
    
    private let ratingStarsBackgroundView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private let ratingStarsForegroundImageView = UIImageView().then {
        $0.image = UIImage(named: "stars_container")
        $0.contentMode = .scaleAspectFill
    }
    
    private let awardView = UIStackView().then {
        $0.distribution = .fillProportionally
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 8
        $0.addRightBorder(color: .lightGray, width: 1, multiplier: 0.4)
    }
    
    private let awardInfoTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "수상",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 12, weight: .light))
    }
    
    private let awardImageView = UIImageView().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        $0.image = UIImage(systemName: "person", withConfiguration: imageConfig)
        $0.tintColor = .gray
        $0.contentMode = .scaleAspectFit
    }
    
    private let awardInfoSubTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "앱",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 14, weight: .light))
    }
    
    private let ageView = UIStackView().then {
        $0.distribution = .fillProportionally
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 8
        $0.addRightBorder(color: .lightGray, width: 1, multiplier: 0.4)
    }
    
    private let ageInfoTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "연령",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 12, weight: .light))
    }
    
    private let ageLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "4+",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 22, weight: .semibold))
    }
    
    private let ageInfoSubTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "세",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 14, weight: .light))
    }
    
    private let newNoticeView = UIView()
    
    private let newNoticeButton = UIButton().then {
        
        var config = UIButton.Configuration.plain()
        // 타이틀
        config.attributedTitle = AttributedString(.makeAttributedString(text: "새로운 소식",
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
    
    private let newAppVersionLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "버전 5.185.0",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 16, weight: .regular))
    }
    
    private let elapsedDaysLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "1일 전",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 16, weight: .regular))
    }
    
    private let versionChangeLogLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.attributedText = .makeAttributedString(text: "• 구석구석 숨어있던 버그들을 잡았어요. 또 다른 버그가 나타나면 토스 고객센터를 찾아주세요. 늘 열려있답니다. 365일 24시간 언제든지요.",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                                  lineHeightMultiple: 1.4)
    }
    
    private let previewView = UIView()
    
    private let previewInfoTitleView = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "미리 보기",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 22, weight: .bold))
    }
    
    private let previewImagesContainerView = UIView()
    
    private let firstPreviewImageView = UIImageView().then {
        $0.image = UIImage(named: "toss_preview_1")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private let compatibleDevicesView = UIView()
    
    private let compatibleDevicesContainerView = UIView().then {
        $0.addBottomBorder(color: .lightGray, width: 1)
    }
    
    private let compatibleDeviceIconImagesStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 10
    }
    
    private let compatibleDeviceIconImageView = UIImageView().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        $0.image = UIImage(systemName: "iphone", withConfiguration: imageConfig)
        $0.tintColor = .lightGray
        $0.contentMode = .scaleAspectFit
    }
    
    private let compatibleDeviceNameLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "iPhone",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 14, weight: .medium))
    }
    
    private let appDetailInfoView = UIView()
    
    private let appDetailInfoLabel = UILabel().then {
        $0.numberOfLines = 3
        $0.attributedText = .makeAttributedString(text: """
토스뱅크, 토스증권 서비스를 이용하시려면 토스 앱 설치가 필요합니다.

● 내 금융 현황을 한눈에, 홈·소비
· 모든 계좌의 모든 정보를 한 곳에서, 따로 보았던 예적금, 청약, 증권, 대출 계좌의 정보를 한 곳에서 확인할 수 있어요.
· 얼마나 벌고 얼마나 썼을까? 한 달 동안의 수입과 소비를 시간순으로 모아볼 수 있고, 소비 분석 리포트도 제공해드려요.
· 카드 실적 헷갈릴 필요 없이, 실적을 충족한 카드가 무엇인지 얼마나 더 써야 실적을 달성하는지 한눈에 확인할 수 있어요.
· 매달 고정적으로 나가는 보험비, 생활요금, 구독료 등도 쉽게 확인할 수 있어요.

● 평생 무료로 간편하고 안전하게, 송금
· 송금을 자유롭게, 토스에서는 은행 상관없이 수수료가 평생 무료에요.
· 송금을 안전하게, 송금 전 사기계좌를 미리 조회해 안전하게 송금할 수 있어요.
· 송금을 간편하게, 단 한 번의 터치까지 줄였어요. 최소한의 터치로 송금하세요.
· 그리고 마음까지, 간단한 메시지와 이모티콘을 함께 보내보세요.

● 지점에 가지 않아도 OK, 개설
· 시간과 장소에 상관없이, 카드, 예·적금, 대출, 보험 등 다양한 금융상품을 개설할 수 있습니다.
· 특별한 혜택은 덤으로, 토스에서만 드리는 혜택 또한 놓치지 마세요.

● 보험 관리를 한눈에, 보험
· 가입한 보험과 월 보험료를 한눈에 확인하세요.
· 또래에 비해 부족한 것은 없을까? 현재 가입한 보험의 보장을 참고해 부족한 보장을 추천해드립니다.
· 전문가와 상담을 통해 내게 딱 맞는 보험을 추천 받고, 병원비도 간편하게 청구해 돌려받을 수 있어요.

● 누구나 받을 수 있는, 혜택
· 좋아하는 브랜드를 더 사랑할 수 있도록, 1주일에 한 번씩 브랜드를 고르고 캐시백을 받아보세요.
· 이번 주 미션을 달성하고 포인트를 받아보세요.
· 걸음 수를 채우고 건강과 혜택을 한 번에, 만보기도 한번 사용해보세요.

● 쓸수록 커지는 혜택, 토스신용카드
· 실적에 따라 더 큰 금액을 돌려드려요.
· 결제 및 캐시백 내역을 토스 앱에서 확인할 수 있어요.
· VISA 플래티늄 서비스 혜택 또한 누려보세요.

● 투자를 모두에게, 토스증권
· 투자의 시작은 관심에서부터, 투자 판단에 도움을 주는 뉴스와 컨텐츠를 확인해보세요.
· 송금처럼 쉬운 구매 경험, 이해하기 쉬운 용어로 나만의 주식 투자를 시작할 수 있어요.

● 완전히 새로운 은행, 토스뱅크
· 채우고, 비우고, 자유롭게, 조건 없는 강력한 통장을 만나보세요.
· 단 한 번의 조회로 가능, 어렵고 복잡한 과정 없는 대출이 기다리고 있어요.
· 다채로운 컬러 그리고 아낌없이 주는 혜택, 토스뱅크 체크카드도 발급받아보세요.

● 가장 가까운 주민센터, 토스 주민센터
· 정부24와 주민센터에서 발급 받았던 민원 증명서, 토스에서 빠르게 받고 낼 수 있어요.
· 건강검진 일정 및 국가장학금 신청 안내, 교통범칙금·과태료 알림도 바로 받고 납부할 수 있어요.

● 사업을 하는 사장님도 편리하게, 내 매출 장부
· 언제 얼마가 입금될까? 매일 알려드리고 매출, 입금 장부를 자동으로 써드려요.
· 사장님 대상 지원 정책도 토스가 챙겨드릴게요.

● 안심하고 쓰세요
· 대한민국 국민 3명 중 1명 사용, 누적 송금액 177조 원, 누적 다운로드 6,900만, 보안사고 0건 (2021년 8월 기준)
· '2018 정보보호대상' 대상 수상 (과학기술정보통신부 주최)
· 해킹 방어수준 25개 금융 앱 중 종합 1위 기록 (2017년 스틸리언 분석)
· 카드사 수준 글로벌 데이터 보안 표준 'PCI-DSS' 업계 최초로 획득
· 국제표준 정보보호 인증 ISO/IEC 27001 및 ISO/IEC 27701 취득
· 24시간 관제 시스템과 이상금융거래탐지시스템으로 각종 위험을 예방

● 토스는 누가 운영하나요?
토스는 핀테크 기업 '비바리퍼블리카'에서 운영합니다.
비바리퍼블리카는 2019년 KPMG와 H2벤처스가 선정한 전 세계 100대 핀테크 기업 중 29위에 선정되었으며, 국내 핀테크 기업 중 가장 많은 은행 및 증권사와 공식 제휴를 맺고 있습니다. 또한 전자금융거래법 제28조에 따라, 보안과 관제 시스템에 대한 금융감독원의 실사 및 금융위원회의 승인을 통해 전자금융업으로 등록, 안전하게 서비스를 제공하고 있습니다.

● 꼭 필요한 권한만 요청합니다
[선택 접근 권한]
· 연락처 : 연락처를 통한 송금과 프로필 사진 등록
· 알림 : ARS 인증번호를 받거나, 토스에서 전달하는 푸시 메세지 수신
· 카메라 : QR코드 / 실물카드 / 신분증 인식, 이미지 업로드, 프로필 등록에 필요
· 사진 : 이미지 저장/업로드 시 필요
· 위치 : 현 위치 확인 및 표시, 부정거래 방지에 필요
· 동작 및 피트니스 : 만보기 서비스에서 걸음 수 측정
· Face ID : 토스 비밀번호 입력을 대체해 인증 진행 시 필요
· 블루투스 : 근처에 있는 기기 식별 및 연결을 위해 필요
* 선택 권한은 허용하지 않아도 서비스를 이용할 수 있으나, 일부 기능 사용에 제한이 있을 수 있습니다.

● 토스 고객센터는 365일 24시간 열려있습니다.
· 전화 1599-4905
· 카카오톡 @toss
· 이메일 support@toss.im

(주)비바리퍼블리카
서울시 강남구 테헤란로 142 아크플레이스 12층
""",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                                  lineHeightMultiple: 1.4)
    }
    
    private let appDetailInfoShowMoreButton = UIButton().then {
        $0.backgroundColor = .white
        
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString(.makeAttributedString(text: "더 보기",
                                                                        color: .systemBlue,
                                                                        font: UIFont.systemFont(ofSize: 16, weight: .regular)))
        config.contentInsets = .zero
        
        $0.configuration = config
    }
    
    private let developerView = UIView()
    
    private let developerNameLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "Viva Republica",
                                                  color: .systemBlue,
                                                  font: UIFont.systemFont(ofSize: 16, weight: .regular))
    }
    
    private let developerTitleInfoLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "개발자",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 14, weight: .regular))
    }
    
    private let developerInfoArrowIconImageView = UIImageView().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        $0.image = UIImage(systemName: "chevron.right", withConfiguration: imageConfig)
        $0.tintColor = .gray
        $0.contentMode = .scaleAspectFit
    }
    
    private let ratingAndReviewsView = UIView()
    
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
    
    private let averageRatingLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "4.4",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 64, weight: .bold))
    }
    
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
    
    private let mostHelpfulReviewTitleInfoLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "가장 도움이 되는 리뷰",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 18, weight: .medium))
    }
    
    private let userReviewView = UIView()
    
    private let userReviewCell = UIView().then {
        $0.backgroundColor = .white
        
        $0.layer.shadowColor = UIColor.gray.cgColor
        $0.layer.shadowRadius = 6
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowOpacity = 0.4
        $0.layer.masksToBounds = false
        
        $0.layer.cornerRadius = 16
    }
    
    private let userReviewTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "35기 YB 최지석",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 18, weight: .medium))
    }
    
    private let userReviewStarsView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private let userReviewStarsBackgroundView = UIView().then {
        $0.backgroundColor = .black
    }
    
    private let userReviewStarsForegroundImageView = UIImageView().then {
        $0.image = UIImage(named: "stars_container")
        $0.contentMode = .scaleAspectFit
    }
    
    private let userReviewDateAndNameLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "10월 18일 · INFP",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 14, weight: .regular))
    }
    
    private let userReviewLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려 강산 대한 사람 대한으로 길이 보전하세",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 14, weight: .regular),
                                                  lineBreakMode: .byTruncatingTail,
                                                  lineBreakStrategy: .hangulWordPriority)
        $0.numberOfLines = 0
    }
    
    private let selfRatingAndReviewView = UIView()
    
    private let selfRatingAndReviewTitleInfoLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "탭하여 평가하기",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 18, weight: .regular))
    }
    
    private let selfRatingStarIconsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 10
    }
    
    private let selfRatingFirstStarIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
    }
    
    private let selfRatingSecondStarIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
    }
    
    private let selfRatingThirdStarIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
    }
    
    private let selfRatingFourthStarIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
    }
    
    private let selfRatingFifthStarIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
    }
    
    private let selfRatingButtonsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.spacing = 12
    }
    
    private let selfReviewWritingButton = UIButton().then {

        var config = UIButton.Configuration.filled()
        // 타이틀
        config.attributedTitle = AttributedString(.makeAttributedString(text: "리뷰 작성",
                                                                        color: .systemBlue,
                                                                        font: UIFont.systemFont(ofSize: 16,
                                                                                                weight: .semibold)))
        // 이미지
        config.image = UIImage(systemName: "square.and.pencil")
        config.imagePadding = 4
        config.imagePlacement = .leading
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 12,
                                                                                  weight: .semibold)
        config.baseForegroundColor = .systemBlue
        config.baseBackgroundColor = UIColor.Week2ColorSet.buttonBackgroundLightGray

        $0.configuration = config
        
        // 커스텀 코너 반경 설정
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }
    
    private let appSupportButton = UIButton().then {

        var config = UIButton.Configuration.filled()
        // 타이틀
        config.attributedTitle = AttributedString(.makeAttributedString(text: "앱 지원",
                                                                        color: .systemBlue,
                                                                        font: UIFont.systemFont(ofSize: 16,
                                                                                                weight: .semibold)))
        // 이미지
        config.image = UIImage(systemName: "questionmark.circle")
        config.imagePadding = 4
        config.imagePlacement = .leading
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 12,
                                                                                  weight: .semibold)
        config.baseForegroundColor = .systemBlue
        config.baseBackgroundColor = UIColor.Week2ColorSet.buttonBackgroundLightGray

        $0.configuration = config
        
        // 커스텀 코너 반경 설정
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        bindAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    deinit {
        print("Detail ViewController Deinit")
    }
    
    private func makeUI() {
        view.backgroundColor = .white
        
        view.addSubViews(
            containerScrollView.addSubViews(
                containerStackView.addArrangedSubViews(
                    // 앱 타이틀 정보 뷰
                    appTitleInfoView,
                    // 앱 정보 수평 스크롤 뷰
                    appInfoHorizontalSwipeContainerView.addSubViews(
                        appInfoHorizontalSwipeStackView.addArrangedSubViews(
                            // 사용자 평점 뷰
                            ratingView.addArrangedSubViews(
                                ratingCountLabel,
                                ratingScoreLabel,
                                ratingStarsView.addSubViews(
                                    ratingStarsBackgroundView,
                                    ratingStarsForegroundImageView
                                )
                            ),
                            // 수상 뷰
                            awardView.addArrangedSubViews(
                                awardInfoTitleLabel,
                                awardImageView,
                                awardInfoSubTitleLabel
                            ),
                            // 연령 뷰
                            ageView.addArrangedSubViews(
                                ageInfoTitleLabel,
                                ageLabel,
                                ageInfoSubTitleLabel
                            )
                        )
                    ),
                    // 새로운 소식 뷰
                    newNoticeView.addSubViews(
                        newNoticeButton,
                        newAppVersionLabel,
                        elapsedDaysLabel,
                        versionChangeLogLabel
                    ),
                    // 앱 프리뷰 이미지 리스트 뷰
                    previewView.addSubViews(
                        previewInfoTitleView,
                        previewImagesContainerView.addSubViews(
                            firstPreviewImageView
                        )
                    ),
                    // 호환 기기 뷰
                    compatibleDevicesView.addSubViews(
                        compatibleDevicesContainerView.addSubViews(
                            compatibleDeviceIconImagesStackView.addArrangedSubViews(
                                compatibleDeviceIconImageView
                            ),
                            compatibleDeviceNameLabel
                        )
                    ),
                    // 앱 디테일 정보 뷰
                    appDetailInfoView.addSubViews(
                        appDetailInfoLabel,
                        appDetailInfoShowMoreButton
                    ),
                    // 개발자 정보 뷰
                    developerView.addSubViews(
                        developerNameLabel,
                        developerTitleInfoLabel,
                        developerInfoArrowIconImageView
                    ),
                    // 평가 및 리뷰 뷰
                    ratingAndReviewsView.addSubViews(
                        ratingAndReviewsButton,
                        averageRatingLabel,
                        ratingAndReviewsStackView.addArrangedSubViews(
                            ratingAndReviewsStarsView.addSubViews(
                                ratingAndReviewsStarsBackgroundView,
                                ratingAndReviewsStarsForegroundImageView
                            ),
                            ratingAndReviewsCountLabel
                        ),
                        mostHelpfulReviewTitleInfoLabel,
                        // 사용자 리뷰 셀
                        userReviewView.addSubViews(
                            userReviewCell.addSubViews(
                                userReviewTitleLabel,
                                userReviewStarsView.addSubViews(
                                    userReviewStarsBackgroundView,
                                    userReviewStarsForegroundImageView
                                ),
                                userReviewDateAndNameLabel,
                                userReviewLabel
                            )
                        )
                    ),
                    // 셀프 평가 뷰
                    selfRatingAndReviewView.addSubViews(
                        selfRatingAndReviewTitleInfoLabel,
                        selfRatingStarIconsStackView.addArrangedSubViews(
                            selfRatingFirstStarIconButton,
                            selfRatingSecondStarIconButton,
                            selfRatingThirdStarIconButton,
                            selfRatingFourthStarIconButton,
                            selfRatingFifthStarIconButton
                        ),
                        selfRatingButtonsStackView.addArrangedSubViews(
                            selfReviewWritingButton,
                            appSupportButton
                        )
                    )
                )
            )
        )
        
        containerScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        containerStackView.setCustomSpacing(20, after: appTitleInfoView)
        
        // MARK: 수평 스크롤 뷰
        appInfoHorizontalSwipeContainerView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
        appInfoHorizontalSwipeStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
            $0.height.equalToSuperview()
        }
        
        ratingView.snp.makeConstraints {
            $0.width.equalTo(108)
        }
        
        ratingStarsView.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(15)
        }
        
        ratingStarsBackgroundView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(4.4 / 5.0)
        }
        
        ratingStarsForegroundImageView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.verticalEdges.equalTo(ratingStarsBackgroundView)
        }
        
        awardView.snp.makeConstraints {
            $0.width.equalTo(108)
        }
        
        ageView.snp.makeConstraints {
            $0.width.equalTo(108)
        }
        
        // MARK: 새로운 소식 뷰
        newNoticeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.left.equalToSuperview().inset(20)
        }
        
        newAppVersionLabel.snp.makeConstraints {
            $0.top.equalTo(newNoticeButton.snp.bottom).offset(12)
            $0.left.equalToSuperview().inset(20)
        }
        
        elapsedDaysLabel.snp.makeConstraints {
            $0.top.equalTo(newNoticeButton.snp.bottom).offset(12)
            $0.right.equalToSuperview().inset(20)
        }
        
        versionChangeLogLabel.snp.makeConstraints {
            $0.top.equalTo(elapsedDaysLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        // MARK: 미리 보기
        previewView.snp.makeConstraints {
            $0.height.equalTo(520)
        }
        
        previewInfoTitleView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.height.equalTo(30)
            $0.left.equalToSuperview().inset(20)
        }
        
        previewImagesContainerView.snp.makeConstraints {
            $0.top.equalTo(previewInfoTitleView.snp.bottom).offset(12)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        firstPreviewImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
            $0.width.equalTo(215)
        }
        
        // MARK: 호환 기기 뷰
        compatibleDevicesView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        compatibleDevicesContainerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
        }
        
        compatibleDeviceIconImagesStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.left.equalToSuperview()
        }
        
        compatibleDeviceIconImageView.snp.makeConstraints {
            $0.size.equalTo(20)
        }
        
        compatibleDeviceNameLabel.snp.makeConstraints {
            $0.left.equalTo(compatibleDeviceIconImagesStackView.snp.right).offset(10)
            $0.centerY.equalTo(compatibleDeviceIconImageView.snp.centerY)
            $0.right.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        
        // MARK: 앱 디테일 정보 뷰
        appDetailInfoLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        // 디테일 정보 텍스트가 3줄을 초과할 경우만 [더 보기] 버튼 노출
        if appDetailInfoLabel.isTextMoreThanLines(3) {
            appDetailInfoShowMoreButton.isHidden = false
        } else {
            appDetailInfoShowMoreButton.isHidden = true
        }
        
        appDetailInfoShowMoreButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.right.equalToSuperview().inset(20)
        }
        
        // MARK: 개발자 정보 뷰
        developerNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.left.equalToSuperview().inset(20)
        }
        
        developerTitleInfoLabel.snp.makeConstraints {
            $0.top.equalTo(developerNameLabel.snp.bottom).offset(3)
            $0.left.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        developerInfoArrowIconImageView.snp.makeConstraints {
            $0.right.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(20)
        }
        
        // MARK: 평가 및 리뷰 뷰
        ratingAndReviewsButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.left.equalToSuperview().inset(20)
        }
        
        averageRatingLabel.snp.makeConstraints {
            $0.top.equalTo(ratingAndReviewsButton.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(20)
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
            $0.width.equalToSuperview().multipliedBy(4.4 / 5.0)
        }
        
        ratingAndReviewsStarsForegroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mostHelpfulReviewTitleInfoLabel.snp.makeConstraints {
            $0.top.equalTo(averageRatingLabel.snp.bottom).offset(12)
            $0.left.equalToSuperview().inset(20)
        }
        
        // MARK: 사용자 리뷰 셀
        userReviewView.snp.makeConstraints {
            $0.top.equalTo(mostHelpfulReviewTitleInfoLabel.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
        
        userReviewCell.snp.makeConstraints {
            $0.height.equalTo(200)
            $0.top.bottom.equalToSuperview().inset(12)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        userReviewTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.equalToSuperview().inset(20)
        }
        
        userReviewStarsView.snp.makeConstraints {
            $0.top.equalTo(userReviewTitleLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(16)
        }
        
        userReviewStarsBackgroundView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(5.0 / 5.0)
        }
        
        userReviewStarsForegroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        userReviewDateAndNameLabel.snp.makeConstraints {
            $0.left.equalTo(userReviewStarsView.snp.right).offset(6)
            $0.centerY.equalTo(userReviewStarsView.snp.centerY)
            $0.right.equalToSuperview().inset(20)
        }
        
        userReviewLabel.snp.makeConstraints {
            $0.top.equalTo(userReviewDateAndNameLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.lessThanOrEqualToSuperview().inset(20)
        }
        
        // MARK: 사용자 본인 리뷰 및 평가 셀
        selfRatingAndReviewTitleInfoLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        selfRatingStarIconsStackView.snp.makeConstraints {
            $0.top.equalTo(selfRatingAndReviewTitleInfoLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        selfRatingButtonsStackView.snp.makeConstraints {
            $0.top.equalTo(selfRatingStarIconsStackView.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func bindAction() {
        appDetailInfoShowMoreButton.addTarget(self, action: #selector(appDetailInfoShowMoreButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func appDetailInfoShowMoreButtonDidTap() {
        appDetailInfoLabel.numberOfLines = 0
        appDetailInfoShowMoreButton.isHidden = true
    }
    
    private func loadData() {
        // json 파일 경로
        guard let url = Bundle.main.url(forResource: "adp_mock", withExtension: "json") else {
            print("JSON file not found")
            return
        }

        // json 파일 디코딩
        do {
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            let adpData = try decoder.decode(ADPData.self, from: data)
            
            print(adpData)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}

// SwiftUI preview
#if DEBUG
import SwiftUI
struct AppstoreDetailControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        AppstoreDetailController()
    }
}

#Preview {
    AppstoreDetailControllerRepresentable()
}
#endif
