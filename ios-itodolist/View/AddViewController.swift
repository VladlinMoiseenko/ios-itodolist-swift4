import UIKit
import RxSwift
import RxCocoa
import Action

class AddViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var addViewModel: AddViewModel!
    var disposeBag = DisposeBag()
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = "New task"
        
        self.navigationItem.rightBarButtonItem?.rx.action = CocoaAction {
            self.activityIndicator.startAnimating()
            
            self.addViewModel = AddViewModel()
            
            let title = self.titleTextField.text
            
            self.addViewModel?.apiTaskCreate(title!)
            
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
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
