
import UIKit

protocol DassDescVCProtocol: AnyObject {
    func startDassAssessment()
}

final class DassDescVC: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var viewRatingHint: UIView!
    @IBOutlet weak var btnStart: UIButton!

    // MARK: Properties
    weak var delegate: DassDescVCProtocol?

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewRatingHint.addRounderBorder(borderWidth: 1,
                                        borderColor: HRThemeColor.blue,
                                        radius: 15)
        btnStart.makeCircular()
        btnStart.backgroundColor = HRThemeColor.blue
    }
    
    // MARK: IBActions
    @IBAction func onTapBtnStart(_ sender: Any) {
        delegate?.startDassAssessment()
    }
}
