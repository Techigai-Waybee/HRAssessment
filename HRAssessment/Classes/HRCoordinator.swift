import Foundation

public final class HRCoordinator {
    let navigationController: UINavigationController
    
    public init(_ navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }

    public func startAssessment(user: UserProfile) {
        let scene = BasePageViewController.instantiate(from: .HealthReel)
        scene.controller = BasePageController(userProfile: user)
        navigationController.pushViewController(scene, animated: true)
    }

    public func showCharts(data: ChartReport = ChartReport.mockData) {
        let chartsScene = ChartsVC.instantiate(from: .HealthReel)
        chartsScene.dataSource = data
        navigationController.pushViewController(chartsScene, animated: true)
    }
    
    public func showReport(data: [ReportModel]) {
        let reportScene = ReportVC.instantiate(from: .HealthReel)
        reportScene.controller = ReportsController(source: data)
        navigationController.pushViewController(reportScene, animated: true)
    }
}

enum PageType {
    case socialNeeds
    case dassDescription
    case dass
    case pregnant
    case preEclampsia
    case selfHealth
    case activityLevel
    case bodyWeight
}

extension PageType {
    struct Configuration {
        let title: String
        let skipButtonTitle: String?
        let hideNextButton: Bool
    }

    var configuration: Configuration {
        switch self {
        case .socialNeeds:
            return .init(title: String(localizedKey: "nav.title.social_needs_screening"),
                         skipButtonTitle: String(localizedKey: "skip.title.sdoh_assessment"),
                         hideNextButton: true)
        case .dassDescription, .dass:
            return .init(title: String(localizedKey: "nav.title.mental_emotional"),
                         skipButtonTitle: String(localizedKey: "skip.title.mental_emotional_assessment"),
                         hideNextButton: true)
        case .pregnant:
            return .init(title: String(localizedKey: "nav.title.preeclampsia_risk_estimation"),
                         skipButtonTitle: nil,
                         hideNextButton: true)
        case .preEclampsia:
            return .init(title: String(localizedKey: "nav.title.preeclampsia_risk_estimation"),
                         skipButtonTitle: nil,
                         hideNextButton: false)
        case .selfHealth:
            return .init(title: String(localizedKey: "nav.title.self_health_readiness"),
                         skipButtonTitle: nil,
                         hideNextButton: false)
        case .activityLevel:
            return .init(title: String(localizedKey: "nav.title.activity_level"),
                         skipButtonTitle: nil,
                         hideNextButton: false)
        case .bodyWeight:
            return .init(title: String(localizedKey: "nav.title.body_weight"),
                         skipButtonTitle: nil,
                         hideNextButton: false)
        }
    }
}
