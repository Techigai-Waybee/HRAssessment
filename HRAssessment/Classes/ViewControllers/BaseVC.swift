import UIKit

public class BaseVC: UIViewController {
    
    // MARK: Properties
    private let deviceWidth = UIScreen.main.bounds.width
    private var offsetY: CGFloat = {
        var offsetY: CGFloat = 10
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            offsetY += windowScene.statusBarManager?.statusBarFrame.height ?? 0.0
        }
        return offsetY
    }()
    
    private lazy var navigationView : UIImageView = {
        let verticalDistaneOfNavigationBar: CGFloat = 0        
        let navigationView = UIImageView(frame: CGRect(x: 0, y: verticalDistaneOfNavigationBar,
                                                       width: deviceWidth, height: 150 + verticalDistaneOfNavigationBar))
        navigationView.backgroundColor = HRThemeColor.navigationBackgroundColor
        navigationView.image = HRImageAsset.navigation_bar.image
        navigationView.isUserInteractionEnabled = true
        return navigationView
    }()
    
    private lazy var backButton: UIButton = {
        // Navigation bar left button
        let button = UIButton(frame: CGRect(x: 10, y: offsetY, width: 30, height: 30))
        let image = UIImage(systemName: "arrow.backward")
        button.imageView?.tintColor = HRThemeColor.white
//        button.imageEdgeInsets = UIEdgeInsets(uniform: 5)
        button.setImage(image, for: .normal)

        button.addTarget(self,
                         action: #selector(onTapNavBarLeftButton),
                         for: .touchUpInside)
        return button
    }()
    
    lazy var navBarTitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 50, y: offsetY - 5,
                                          width: deviceWidth - 50, height: 40))
        label.font = HRFonts.navigationTitleFont
        label.textColor = HRThemeColor.white
        return label
    }()
    
    lazy var navSkipButton: UIButton = {
        // Navigation bar Skip button
        let navSkipButton = UIButton(frame: CGRect(x: Int(deviceWidth - 100), y: Int(offsetY),
                                                   width: 100, height: 30))
        navSkipButton.setAttributedTitle(NSAttributedString(string: "Skip",
                                                            attributes: [.font: HRFonts.navigationTitleFont]),
                                         for: .normal)
        navSkipButton.setTitleColor(HRThemeColor.white, for: .normal)
        navSkipButton.isHidden = true
        navSkipButton.addTarget(self, action: #selector(onTapNavBarSkipButton), for: .touchUpInside)
        return navSkipButton
    }()
    
    lazy var navShareButton: UIButton = {
        // Navigation bar Share button
        var config = UIButton.Configuration.borderless()
        config.image = HRImageAsset.icon_share.image(with: HRThemeColor.white)
        config.imagePadding = 5
        config.imagePlacement = .leading
        config.baseForegroundColor = .white

        let navShareButton = UIButton(configuration: config)
        navShareButton.frame = CGRect(x: Int(deviceWidth - 50),
                                      y: Int(offsetY),
                                      width: 30, height: 30)
        navShareButton.isHidden = true
        navShareButton.addTarget(self,
                                 action: #selector(onTapNavBarShareButton),
                                 for: .touchUpInside)
        return navShareButton
    }()
    
    // MARK: Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationBar()
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: Actions
    @objc func onTapNavBarLeftButton() {
        navigationController?.popViewController(animated: true)
    }

    @objc func onTapNavBarSkipButton() {
        
    }

    @objc func onTapNavBarShareButton() {

    }

    // MARK: Functions
    private func createNavigationBar() {
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(navigationView)
        navigationView.addSubview(backButton)
        navigationView.addSubview(navBarTitleLabel)
        navigationView.addSubview(navShareButton)
        navigationView.addSubview(navSkipButton)
    }
}
