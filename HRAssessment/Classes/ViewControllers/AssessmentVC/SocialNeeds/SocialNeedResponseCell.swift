
import UIKit

final class SocialNeedResponseCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        
        container.addRounderBorder2(radius: 20, showShadow: false)
        container.dropShadow()
    }

    // MARK: Functions
    func setupUI(title: String, isSelected: Bool) {
        titleLabel.text = title

        if isSelected {
            container.backgroundColor = HRThemeColor.blue
            titleLabel.textColor = HRThemeColor.white
        } else {
            container.backgroundColor = HRThemeColor.white
            titleLabel.textColor = HRThemeColor.blue
        }
    }
}
