
import UIKit

final class ReportsTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblTrend: UILabel!
    @IBOutlet weak var iconTrend: UIImageView!
    
    // MARK: Functions
    func populate(data: CategorisedReport.DataPoint, reportModel: ReportModel) {
        lblTitle.text = data.title
        
        guard let value = reportModel.valueFor(data.valueKey) else {
            lblScore.text = ""
            return
        }
        
        lblTitle.text = data.titleFor(value: value)
        lblScore.text = data.format(value: value)
        
        guard let trendKey = data.trendKey,
              let trend = reportModel.trendFor(trendKey) else {
            lblTrend.text = ""
            iconTrend.image = nil
            return
        }
        
        lblTrend.text = trend.value.string
        
        let color = trend.isPositive ? HRThemeColor.green : HRThemeColor.red
        lblTrend.textColor = color
        
        let iconTrendUp = HRImageAsset.icon_trend_up.image(with: color)
        let iconTrendDown = HRImageAsset.icon_trend_down.image(with: color)
    
        iconTrend.image = trend.hasIncreased ? iconTrendUp : iconTrendDown
        iconTrend.tintColor = color
    }
}

extension Double {
    var string: String {
        String(format: "%.1f", self)
    }
}
