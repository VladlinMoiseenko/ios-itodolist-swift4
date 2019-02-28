
import UIKit
import RxSwift
import RxCocoa
import RxOptional

enum KeepingState {
    case keeping
    case release
    
}

struct TableCellViewModel {
    let id = UUID().uuidString
    var name: String
    var age: Int
    var message: String
    var count: Int
    var isKeeping: Bool
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var keepingStateView: UIView!
    
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
        nameLabel.text = viewModel.name
        ageLabel.text = "age: \(viewModel.age)"
        messageLabel.text = viewModel.message
        counterLabel.text = "\(viewModel.count)"
        
        keepingStateView.backgroundColor = viewModel.isKeeping ? UIColor.green : UIColor.black
    }
    
}
