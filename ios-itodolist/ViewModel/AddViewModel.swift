import RxSwift
import RxCocoa
import RxDataSources

class AddViewModel {
    
    var apiController: ApiController?
    
    func apiTaskCreate(_ title:String, _ content:String) {
        
        apiController = ApiController()
        
        let jsonParam = try? JSONEncoder().encode(TaskDataSave(title: title, content: content))
        let param = try? JSONSerialization.jsonObject(with: jsonParam!, options: []) as? [String : Any]
        
        apiController?.taskCreate(param: param as! [String : Any], success: {modelStatus in
//            if modelTask.status == 1 {
//
//            }

        }, failure: { errorMsg in
            print(errorMsg)
        })
        
    }
    
}
