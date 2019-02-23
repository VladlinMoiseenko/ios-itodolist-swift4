import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Action

enum SharedInput {
    case barButton
    //case barButton
}

class ViewController: UIViewController {

    @IBOutlet var _username: UITextField!
    @IBOutlet var _password: UITextField!
    @IBOutlet var _login_button: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var button: UIButton!
    
    var loginViewModel: LoginViewModel?
       
    var timer = Timer()
    
    let disposeBag = DisposeBag()
    
    let sharedAction = Action<SharedInput, String> { input in
        switch input {
        case .barButton: return Observable.just("UIBarButtonItem with 3 seconds delay").delaySubscription(3, scheduler: MainScheduler.instance)
        //case .button(let title): return .just("UIButton " + title)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _username.text = "demo11"
        _password.text = "demo11"
        
        let username = _username.text
        let password = _password.text
        
        loginViewModel = LoginViewModel()
        
        let action = CocoaAction {
            print("Кнопка была нажата")
            return Observable.create { [weak self] observer -> Disposable in
            
            UserDefaults.standard.set("empty", forKey: "accessToken")
                
                self!.loginViewModel?.apiAuthorize(username!, password!)
                
                //Observable.just("UIBarButtonItem with 3 seconds delay").delaySubscription(3, scheduler: MainScheduler.instance)
                
                //self!.button.rx.bind(to: self!.sharedAction, input: .barButton)
                
                print("at", UserDefaults.standard.string(forKey: "accessToken"))
                
                observer.onCompleted()
               
                print("at", UserDefaults.standard.string(forKey: "accessToken"))
                
                return Disposables.create()
                
            }
        }
        
        //button.rx.bind(to: sharedAction, input: .barButton)
        
        button.rx.action = action
        
        button.rx.action!.executing.debounce(0, scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] executing in
            if (executing) {
                self?.activityIndicator.startAnimating()
            }
            else {
                self?.activityIndicator.stopAnimating()
            }
        }).disposed(by: self.disposeBag)

        
        
        
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        
//        let username = _username.text
//        let password = _password.text
//
//        if (username == "") {
//            let alert = UIAlertController(title: "Username is empty", message: "Please type username.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true)
//            return
//        }
//        if (password == "") {
//            let alert = UIAlertController(title: "Password is empty", message: "Please type password.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true)
//            return
//        }
//
//        doLogin(username!, password!)
    }
    
    func doLogin(_ username:String, _ password:String) {
        
        self.activityIndicator.startAnimating()
        self._login_button.isEnabled = false
        
        UserDefaults.standard.set("empty", forKey: "accessToken")
        
        loginViewModel?.apiAuthorize(username, password)

        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(doLoginOnward), userInfo: nil, repeats: false)
    }
    
    @objc func doLoginOnward() {
        if UserDefaults.standard.string(forKey: "accessToken") != "empty" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            
            self.activityIndicator.stopAnimating()
            self._login_button.isEnabled = true
            
            let alert = UIAlertController(title: "Username or Password incorrect", message: "Please re-type username or password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    

}

