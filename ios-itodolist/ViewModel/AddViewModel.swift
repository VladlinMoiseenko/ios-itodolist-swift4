import RxSwift
import RxCocoa
import RxDataSources

class AddViewModel {
    
    var apiController: ApiController?
    
    func apiTaskCreate(_ title:String) {
        
        apiController = ApiController()
        
        //let title: String = "new title"
        
        let jsonParam = try? JSONEncoder().encode(TaskDataSave(title: title))
        let param = try? JSONSerialization.jsonObject(with: jsonParam!, options: []) as? [String : Any]
        
        //print("param", param)
        
        apiController?.taskCreate(param: param as! [String : Any], success: {modelStatus in
                print(modelStatus)
//            if modelTask.status == 1 {
//
//            }

        }, failure: { errorMsg in
            print(errorMsg)
        })
        
    }
    
}
