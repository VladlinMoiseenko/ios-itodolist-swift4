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
    
    init() {
        self.idtask = ""
        self.title = ""
        self.content = ""
    }
    
    init(json: [String: Any]) {
        idtask = json["id"] as? String ?? ""
        title = json["title"] as? String ?? ""
        content = json["content"] as? String ?? ""
    }
    
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var viewModel: TableCellViewModelTask!
    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
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
        titleLabel.text = viewModel.title
        contentLabel.text = viewModel.content
    }
    
}
