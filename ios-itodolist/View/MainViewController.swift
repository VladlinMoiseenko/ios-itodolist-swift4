import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MainViewController: UIViewController {
 
    @IBOutlet weak var tableView: UITableView!
    
    var mainViewModel: MainViewModel?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()

        mainViewModel = MainViewModel()
        
        let datasource = RxTableViewSectionedReloadDataSource<SectionViewModel>(configureCell: { (dataSource, tableView, indexPath, mainViewModel) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = mainViewModel.title
            cell.detailTextLabel?.text = mainViewModel.timeString
            
            cell.textLabel?.isHighlighted = mainViewModel.isCollision
            cell.detailTextLabel?.isHighlighted = mainViewModel.isCollision
            return cell
            
        }, titleForHeaderInSection: { (dataSource, index) in
            return dataSource[index].header
        })
        
        mainViewModel?.scheduleItems.asObservable()
            .bind(to: tableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
    }
    
    private func setupNavigationBarItems() {
        
        navigationItem.hidesBackButton = true
        
        let titleLabel = UILabel()
        titleLabel.text = "Tasks"
        navigationItem.titleView = titleLabel
        
        let logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoutButton)
    }
    
    @objc func logoutButtonAction() {
        print("Logout is tapped")
    }
    


}
