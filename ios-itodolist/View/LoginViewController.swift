import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Action

class ViewController: UIViewController {

    @IBOutlet var _username: UITextField!
    @IBOutlet var _password: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var _login_button: UIButton!
    
    var loginViewModel: LoginViewModel?
       
    var timer = Timer()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _username.text = "demo11"
        _password.text = "demo11"
        
        loginViewModel = LoginViewModel()
        
        _login_button.rx.tap
            .subscribe(onNext: { _ in
                
                let username = self._username.text
                let password = self._password.text
                
                if (username == "") {
                    let alert = UIAlertController(title: "Username is empty", message: "Please type username.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
                if (password == "") {
                    let alert = UIAlertController(title: "Password is empty", message: "Please type password.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
                
                UserDefaults.standard.set("empty", forKey: "accessToken")

                self.loginViewModel?.apiAuthorize(username!, password!)
                
                self.activityIndicator.startAnimating()
                self._login_button.isEnabled = false
                
                self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.doLoginOnward), userInfo: nil, repeats: false)
                
            }
            )
            .disposed(by: disposeBag)
        
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

