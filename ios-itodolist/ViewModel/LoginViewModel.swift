import RxSwift
import RxCocoa
import RxDataSources

class LoginViewModel {
    
    var apiController: ApiController?
    
    func apiAuthorize(_ username:String, _ password:String) {
        
        apiController = ApiController()
        
        let jsonParam = try? JSONEncoder().encode(Credentials(username: username, password: password))
        let param = try? JSONSerialization.jsonObject(with: jsonParam!, options: []) as? [String : Any]

        apiController?.authorize(param: param as! [String : Any], success: {modelAuthorize in
            
        if modelAuthorize.status == 1 {
            let param = ["authorization_code" : modelAuthorize.authorizationCode]
            self.apiController?.accesstoken(param: param as! [String : Any], success: {modelAccesstoken in

                if modelAccesstoken.status == 1 {
                    UserDefaults.standard.set(modelAccesstoken.accessToken, forKey: "accessToken")
                } else {
                    UserDefaults.standard.set("empty", forKey: "accessToken")
                }

            }, failure: { errorMsg in
                print(errorMsg)
            })

        } else {
            UserDefaults.standard.set("empty", forKey: "accessToken")
        }

        }, failure: { errorMsg in
            print(errorMsg)
        })

    }

}
