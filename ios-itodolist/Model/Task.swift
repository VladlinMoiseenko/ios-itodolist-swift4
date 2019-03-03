struct Task: Decodable {
    
    let status: Int
    //let data: Array<Any>
    
    enum CodingKeys: String, CodingKey {
        case status
        //case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try! container.decode(Int.self, forKey: .status)
    }
    
    init() {
        self.status = 0
        //self.data = []
    }
    
    init(jsonDict: [String: Any]) {
        status = jsonDict["status"] as? Int ?? 0
        //data = jsonDict["data"] as? Array<Any> ?? []
    }
    
}


//struct TaskData {
//    let id: String
//    let title: String
//    let count: Int
//
//    init() {
//        self.id = ""
//        self.title = ""
//        self.count = 0
//    }
//
//    init(json: [String: Any]) {
//        id = json["id"] as? String ?? ""
//        title = json["title"] as? String ?? ""
//        count = 0
//    }
//}
