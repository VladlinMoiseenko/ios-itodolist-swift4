import UIKit
import RxSwift
import RxCocoa
import RxOptional

enum KeepingState {
    case keeping
    case release
    
}

struct TableCellViewModelTask {
    let id = UUID().uuidString
    let idtask: String
    var title: String
    var content: String
    var count: Int
    
    init() {
        self.idtask = ""
        self.title = ""
        self.content = ""
        self.count = 0
    }
    
    init(json: [String: Any]) {
        idtask = json["id"] as? String ?? ""
        title = json["title"] as? String ?? ""
        content = json["content"] as? String ?? ""
        count = 0
    }
    
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    
    var viewModel: TableCellViewModelTask!
    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    public func configure(viewModel: TableCellViewModelTask) {
        self.viewModel = viewModel
        updateUI(viewModel: viewModel)
    }
    
    private func updateUI(viewModel: TableCellViewModelTask){
        nameLabel.text = viewModel.title
        ageLabel.text = viewModel.idtask
        counterLabel.text = "\(viewModel.count)"
    }
    
}