import Alamofire
import Foundation
import RxSwift
import RxAlamofire

class ApiController {
    
    let disposeBag = DisposeBag()
    let ENDPOINT_URL = "http://apitdlist.vladlin.ru/"
    
    func authorize(param:[String : Any], success: @escaping (Authorize) -> Void, failure: @escaping (String) -> Void) {
        
        RxAlamofire.requestData(.post,
                                ENDPOINT_URL+"v1/authorize",
                                parameters: param,
                                encoding: JSONEncoding.default,
                                headers: ["Content-Type": "application/json"])
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { resp, data in
                do {
                    let modelAuthorize: Authorize = try JSONDecoder().decode(Authorize.self, from: data)
                    print(modelAuthorize)
                    success(modelAuthorize)
                } catch {
                    let modelAuthorize = Authorize()
                    print(modelAuthorize)
                    success(modelAuthorize)
                }
            }, onError: { error in
                failure("Error")
            })
            .disposed(by: disposeBag)
    }
    
    func accesstoken(param:[String : Any], success: @escaping (Accesstoken) -> Void, failure: @escaping (String) -> Void) {
        RxAlamofire.requestData(.post,
                                ENDPOINT_URL+"v1/accesstoken",
                                parameters: param,
                                encoding: JSONEncoding.default,
                                headers: ["Content-Type": "application/json"])
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { resp, data in
                let modelAccesstoken: Accesstoken = try! JSONDecoder().decode(Accesstoken.self, from: data)
                success(modelAccesstoken)
            }, onError: { error in
                failure("Error")
            })
            .disposed(by: disposeBag)
    }
    
    func fetchTasksData(success: @escaping (TaskData) -> Void, failure: @escaping (String) -> Void) {
        RxAlamofire.requestJSON(.get, "http://apitdlist.dev.vladlin.ru/v1/task")
            .observeOn(MainScheduler.instance)
            .map { (r, json) -> [String: Any] in
                guard let jsonDict = json as? [String: Any] else {
                    return [:]
                }
                return jsonDict
            }
            .subscribe(onNext: { jsonDict in
                //let model = Task(jsonDict: jsonDict)
                
                if let array = jsonDict["data"] as? [Any] {
                    for object in array {
                        if let ob = object as? [String: Any] {
                            let dmodel = TaskData(json: ob)
                            success(dmodel)
                        }
                    }
                }
                
            }, onError: { error in
                failure("Error")
            })
            .disposed(by: disposeBag)
    }
    
}
