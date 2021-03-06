import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MainViewController: UIViewController {
 
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MainViewModel!
    var disposeBag = DisposeBag()
    var dataSources: RxTableViewSectionedAnimatedDataSource<SectionModel>!
    var timer = Timer()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupNavigationBarItems()
        configureTableView()
        bindRx()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableView.tableFooterView = UIView()
    }
    
    private func bindRx() {
        self.disposeBag = DisposeBag()
        self.viewModel = MainViewModel()
        
        let animationConfiguration = AnimationConfiguration(insertAnimation: .fade,
                                                            reloadAnimation: .fade,
                                                            deleteAnimation: .fade)
        
        dataSources = RxTableViewSectionedAnimatedDataSource<SectionModel>
            .init(animationConfiguration: animationConfiguration,
                  decideViewTransition: { (dataSources, tableView, changeSet) -> ViewTransition in
                    return .animated
            }, configureCell: { (dataSource, tableView, indexPath, item) -> UITableViewCell in
                
//                if indexPath.row == 0 {
//                    print("[indexPath:0], \(item), count:\(item.itemCount)")
//                }
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
                if let cell = cell as? TableViewCell {
                    cell.configure(viewModel: item.viewModel)
                    
                }
                return cell
            }, titleForHeaderInSection: { (dataSource, section) -> String? in
                return nil
            }, titleForFooterInSection: { (dataSource, section) -> String? in
                return nil
            }, canEditRowAtIndexPath: { (dataSource, indexPath) -> Bool in
                return false
            }, canMoveRowAtIndexPath: { (dataSource, indexPath) -> Bool in
                return false
            }, sectionIndexTitles: { (dataSource) -> [String]? in
                return nil
            }, sectionForSectionIndexTitle: { (dataSource, title, index) -> Int in
                return index
            })
        
        viewModel.items
            //.debug()
            .bind(to: tableView.rx.items(dataSource: dataSources))
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { (at: $0, animated: false) }
            .subscribe(onNext: tableView.deselectRow)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(SectionItem.self)
            .subscribe(onNext: { [weak self] item in
                //self?.viewModel.tapped(cellViewModel: item.viewModel)

                let storyboard = UIStoryboard(name: "Edit", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "Edit") as? EditViewController
                vc!.idtask = item.viewModel.idtask
                vc!.titletask = item.viewModel.title
                vc!.content = item.viewModel.content
                self!.navigationController?.pushViewController(vc!, animated: true)
                
            }).disposed(by: disposeBag)
        
    }
    
    private func setupNavigationBarItems() {

        let logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoutButton)

        let addButton = UIButton(type: .contactAdd)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        
    }
    
    @objc func logoutButtonAction() {
        self.viewModel = MainViewModel()
        self.viewModel?.apiLogout()
        
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.doLogoutOnward), userInfo: nil, repeats: false)        
    }
    
    @objc func doLogoutOnward() {
        if UserDefaults.standard.string(forKey: "accessToken") == "empty" {
            guard let vc = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() else {
                return
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func addButtonAction() {
        guard let vc = UIStoryboard(name: "Add", bundle: nil).instantiateInitialViewController() else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MainViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
