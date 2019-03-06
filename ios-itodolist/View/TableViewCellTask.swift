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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    
    var viewModel: TableCellViewModelTask!
    var disposeBag = DisposeBag()

    //
    @objc func myItemAction(_ sender:AnyObject?){
        print("Delete")
    }
    @objc func Edit(_ sender:AnyObject?){
        print("Edit")
    }
    
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
        titleLabel.text = viewModel.title
        contentLabel.text = viewModel.content
        counterLabel.text = "\(viewModel.count)"
    }
    
}
