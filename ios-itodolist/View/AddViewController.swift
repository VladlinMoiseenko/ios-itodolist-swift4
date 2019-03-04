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
        print(123)
        
        addViewModel = AddViewModel()
        
        self.addViewModel?.apiTaskCreate()
        
//        let name = nameTextField.text ?? ""
//        let ageText = ageTextField.text ?? "20"
//        let age = Int(ageText) ?? 20
//        let message = messageTextField.text ?? ""
//        let count = 0
//        let isKeeping = keepingSwitch.isOn
//        let cellViewModel = TableCellViewModel(name: name,
//                                               age: age,
//                                               message: message,
//                                               count: count,
//                                               isKeeping: isKeeping)
//        DataSubject.AddedNotification.on(.next(cellViewModel))
//        self.navigationController?.popViewController(animated: true)
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