
import UIKit
import RxSwift
import RxCocoa
import RxOptional

enum KeepingState {
    case keeping
    case release
    
}

struct TableCellViewModel {
    //let id = UUID().uuidString
    let id: String
    var title: String
    var count: Int
    
    init() {
        self.id = ""
        self.title = ""
        self.count = 0
    }
    
    init(json: [String: Any]) {
        id = json["id"] as? String ?? ""
        title = json["title"] as? String ?? ""
        count = 0
    }
    
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    //@IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    //@IBOutlet weak var keepingStateView: UIView!
    
    var viewModel: TableCellViewModel!
    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    public func configure(viewModel: TableCellViewModel) {
        self.viewModel = viewModel
        updateUI(viewModel: viewModel)
    }
    
    private func updateUI(viewModel: TableCellViewModel){
        nameLabel.text = viewModel.title
        ageLabel.text = viewModel.id
        counterLabel.text = "\(viewModel.count)"
    }
    
}
