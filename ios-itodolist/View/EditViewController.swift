import UIKit
import RxSwift
import RxCocoa
import Action

class EditViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var idtask: String = "empty"
    var titletask: String = "empty"
    var content: String = "empty"
    
    //var editViewModel: EditViewModel!
    var disposeBag = DisposeBag()
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.text = titletask
        contentTextField.text = content
        
        print("idtask:", idtask)
        
        self.navigationItem.rightBarButtonItem?.rx.action = CocoaAction {
            self.activityIndicator.startAnimating()
            
            //self.editViewModel = EditViewModel()
            
            let title = self.titleTextField.text
            let content = self.contentTextField.text
            
            //self.editViewModel?.apiTaskUpdate(idtask!, title!, content!)
            
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
    
}
