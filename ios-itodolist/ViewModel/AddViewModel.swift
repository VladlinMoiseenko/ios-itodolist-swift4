import RxSwift
import RxCocoa

class AddViewModel {
    
    var apiController: ApiController?
    
    func apiTaskCreate() {
        
        apiController = ApiController()
        
        let _title: String = "new title"
        let _id: String = "id"
        
//        let jsonParam = try? JSONEncoder().encode(TaskData(title: _title, id: _id))
//        let param = try? JSONSerialization.jsonObject(with: jsonParam!, options: []) as? [String : Any]
        
//        apiController?.authorize(param: param as! [String : Any], success: {modelAuthorize in
//
//            if modelAuthorize.status == 1 {
//
//            }
//
//        }, failure: { errorMsg in
//            print(errorMsg)
//        })
        
    }
    
}
