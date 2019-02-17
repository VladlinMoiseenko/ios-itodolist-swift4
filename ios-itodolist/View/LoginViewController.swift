import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Action

class ViewController: UIViewController {

    @IBOutlet var _username: UITextField!
    @IBOutlet var _password: UITextField!
    @IBOutlet var _login_button: UIButton!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    var loginViewModel: LoginViewModel?
       
    var timer = Timer()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _username.text = "demo11"
        _password.text = "demo11"
        
        loginViewModel = LoginViewModel()
        
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        
        let username = _username.text
        let password = _password.text
        
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
        
        doLogin(username!, password!)
    }
    
    func doLogin(_ username:String, _ password:String) {
        
        self.indicatorView.startAnimating()
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
            
            self.indicatorView.stopAnimating()
            self._login_button.isEnabled = true
            
            let alert = UIAlertController(title: "Username or Password incorrect", message: "Please re-type username or password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    

}

