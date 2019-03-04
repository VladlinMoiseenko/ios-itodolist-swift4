import UIKit

class AddDataViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var keepingSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addAction(_ sender: Any) {
        print(123)
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
