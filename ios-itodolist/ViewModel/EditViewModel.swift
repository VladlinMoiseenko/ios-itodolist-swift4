import RxSwift

class EditViewModel {
    
    var apiController: ApiController?
    
    func apiTaskUpdate(_ idtask:String, _ title:String, _ content:String) {
        
        apiController = ApiController()
        
        let jsonParam = try? JSONEncoder().encode(TaskDataSave(title: title, content: content))
        let param = try? JSONSerialization.jsonObject(with: jsonParam!, options: []) as? [String : Any]
        
        apiController?.taskUpdate(idtask: idtask, param: param as! [String : Any], success: {modelStatus in
            
        }, failure: { errorMsg in
            print(errorMsg)
        })
    }
   
    func apiTaskDelete(_ idtask:String) {
        
        apiController = ApiController()
        
        apiController?.taskDelete(idtask: idtask, success: {modelStatus in
            
        }, failure: { errorMsg in
            print(errorMsg)
        })
    }
    
}
