import UIKit
import RxSwift
import RxCocoa
import Action

class AddViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var addViewModel: AddViewModel!
    var disposeBag = DisposeBag()
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = "New task"
        contentTextField.text = "Content"
        
        self.navigationItem.rightBarButtonItem?.rx.action = CocoaAction {
            self.activityIndicator.startAnimating()
            
            self.addViewModel = AddViewModel()
            
            let title = self.titleTextField.text
            let content = self.contentTextField.text
            
            self.addViewModel?.apiTaskCreate(title!, content!)
            
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.doOnward), userInfo: nil, repeats: false)

            return Observable.empty().delaySubscription(2, scheduler: MainScheduler.instance) 
        }
          
    }

    @objc func doOnward() {
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
