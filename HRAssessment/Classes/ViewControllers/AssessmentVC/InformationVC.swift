import UIKit

final class InformationVC: UIViewController {
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
        
    var information = (title: "", desc: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        dismissButton.setImage(UIImage(systemName: "xmark",
                                       withConfiguration: .none),
                               for: .normal)
        titleLabel.text = information.title
        descriptionLabel.text = information.desc
    }
}
