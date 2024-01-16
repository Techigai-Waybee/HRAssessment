
import UIKit

final class ReportDateCollectionViewCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblDate: UILabel!
    
    // MARK: Functions
    func setupUI(isSelected: Bool) {
        viewContainer.addRounderBorder2(radius: 4, showShadow: false)
        viewContainer.dropShadow()
        
        viewContainer.backgroundColor = isSelected ? HRThemeColor.anotherBlue : HRThemeColor.white
        lblDate.textColor = isSelected ? HRThemeColor.white : HRThemeColor.black
    }
}
