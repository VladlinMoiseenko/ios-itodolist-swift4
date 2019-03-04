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
            //.debug()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { resp, data in
                do {
                    let modelAuthorize: Authorize = try JSONDecoder().decode(Authorize.self, from: data)
                    success(modelAuthorize)
                } catch {
                    let modelAuthorize = Authorize()
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
    
    func logout(success: @escaping (Logout) -> Void, failure: @escaping (String) -> Void) {
        let accessToken:String = UserDefaults.standard.string(forKey: "accessToken")!
        let headers = ["Content-Type": "application/json", "Authorization" : accessToken]
        RxAlamofire.requestData(.get,
                                ENDPOINT_URL+"v1/logout",
                                encoding: JSONEncoding.default,
                                headers: headers)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { resp, data in
                let modelLogout: Logout = try! JSONDecoder().decode(Logout.self, from: data)
                success(modelLogout)
            }, onError: { error in
                failure("Error")
            })
            .disposed(by: disposeBag)
    }
    
    
//    func getTasks(success: @escaping ([TableCellViewModelTask]) -> Void, failure: @escaping (String) -> Void) {
//        RxAlamofire.requestData(.get,
//                                ENDPOINT_URL+"v1/task",
//                                encoding: JSONEncoding.default,
//                                headers: ["Content-Type": "application/json", "Authorization" : "aa946c25b8baa8196d46f05391865304"])
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { resp, data in
//                let modelTask: Task = try! JSONDecoder().decode(Task.self, from: data)
//                print("task", modelTask)
//                //success(modelTask)
//            }, onError: { error in
//                failure("Error")
//            })
//            .disposed(by: disposeBag)
//    }
    
    func getTasks(success: @escaping ([TableCellViewModelTask]) -> Void, failure: @escaping (String) -> Void) {
        let accessToken:String = UserDefaults.standard.string(forKey: "accessToken")!
        let headers = ["Content-Type": "application/json", "Authorization" : accessToken]
        RxAlamofire.requestJSON(.get,
                                ENDPOINT_URL+"v1/task",
                                encoding: JSONEncoding.default,
                                headers: headers)
            .observeOn(MainScheduler.instance)
            .map { (r, json) -> [String: Any] in
                guard let jsonDict = json as? [String: Any] else {
                    return [:]
                }
                return jsonDict
            }
            .subscribe(onNext: { jsonDict in
                var items: [TableCellViewModelTask] = []
                if let array = jsonDict["data"] as? [Any] {
                    for object in array {
                        if let ob = object as? [String: Any] {
                            let dmodel = TableCellViewModelTask(json: ob)
                            items.append(dmodel)
                        }
                    }
                }
                success(items)
            }, onError: { error in
                failure("Error")
            })
            .disposed(by: disposeBag)
    }
    
    func taskCreate(param:[String : Any], success: @escaping (Task) -> Void, failure: @escaping (String) -> Void) {
        let headers = ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")! as String]
        RxAlamofire.requestData(.post,
                                ENDPOINT_URL+"v1/task/create",
                                parameters: param,
                                encoding: JSONEncoding.default,
                                headers: headers)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { resp, data in
                let modelTask: Task = try! JSONDecoder().decode(Task.self, from: data)
                success(modelTask)
            }, onError: { error in
                failure("Error")
            })
            .disposed(by: disposeBag)
    }  
    
    
//    func getTasksData(success: @escaping ([TableCellViewModelTask]) -> Void, failure: @escaping (String) -> Void) {
//        RxAlamofire.requestJSON(.get, "http://apitdlist.dev.vladlin.ru/v1/task")
//            .observeOn(MainScheduler.instance)
//            .map { (r, json) -> [String: Any] in
//                guard let jsonDict = json as? [String: Any] else {
//                    return [:]
//                }
//                return jsonDict
//            }
//            .subscribe(onNext: { jsonDict in
//
//                var items: [TableCellViewModelTask] = []
//
//                if let array = jsonDict["data"] as? [Any] {
//                    for object in array {
//                        if let ob = object as? [String: Any] {
//                            let dmodel = TableCellViewModelTask(json: ob)
//
//                            items.append(dmodel)
//
//                        }
//                    }
//                }
//                success(items)
//
//            }, onError: { error in
//                failure("Error")
//            })
//            .disposed(by: disposeBag)
//    }
    
}
