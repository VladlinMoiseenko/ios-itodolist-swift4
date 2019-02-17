struct Task {
    
    let status: Int
    let title: String
    let data: Array<Any>
    
    init() {
        self.status = 0
        self.title = ""
        self.data = []
    }
    
    init(jsonDict: [String: Any]) {
        status = jsonDict["status"] as? Int ?? 0
        title = jsonDict["title"] as? String ?? ""
        data = jsonDict["data"] as? Array<Any> ?? []
    }
    
}

struct TaskData {
    let id: String
    let title: String
    
    init() {
        self.id = ""
        self.title = ""
    }
    
    init(json: [String: Any]) {
        id = json["id"] as? String ?? ""
        title = json["title"] as? String ?? ""
    }
}
