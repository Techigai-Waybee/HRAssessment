
import UIKit

protocol SelfHealthVCDelegate: AnyObject {
    func selfHealthResponseUpdated(for question: SelfHealthReadinessQuestion,
                                   response: SelfHealthReadinessResponse)
    func selfHealthResponse(for question: SelfHealthReadinessQuestion) -> SelfHealthReadinessResponse?
    var selfHealthQuestions: [SelfHealthReadinessQuestion] { get }
}

final class SelfHealthReadinessVC: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    weak var delegate: SelfHealthVCDelegate!

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 160
        tableView.estimatedRowHeight = 160
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate.selfHealthQuestions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelfHealthReadinessCell", for: indexPath) as? SelfHealthReadinessCell else {
            return UITableViewCell()
        }

        let question = delegate.selfHealthQuestions[indexPath.row]
        cell.populate(question: question,
                      sliderValue: delegate.selfHealthResponse(for: question))
        cell.delegate = self
        return cell
    }
}

extension SelfHealthReadinessVC: SelfHealthReadinessCellDelegate {
    func sliderValueUpdated(question: SelfHealthReadinessQuestion, value: Int) {
        delegate.selfHealthResponseUpdated(for: question, response: value)
    }
}
