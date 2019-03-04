import UIKit
import RxSwift
import RxCocoa

class AddViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    var addViewModel: AddViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = "New task"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addAction(_ sender: Any) {

        addViewModel = AddViewModel()
        
        let title = self.titleTextField.text
        
        self.addViewModel?.apiTaskCreate(title!)
        
        //DataSubject.AddedNotification.on(.next(addAction(<#T##sender: Any##Any#>)),
        self.navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
