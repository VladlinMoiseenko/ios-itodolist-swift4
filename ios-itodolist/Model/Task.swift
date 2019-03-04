struct Task: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
    
    let status: Int
    let data: [TaskData]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try! container.decode(Int.self, forKey: .status)
        self.data = try! container.decode([TaskData].self, forKey: .data)
    }
    
    init() {
        self.status = 0
        self.data = []
    }
    
    init(jsonDict: [String: Any]) {
        status = jsonDict["status"] as? Int ?? 0
        data = jsonDict["data"] as! [TaskData]
    }
    
}

struct TaskDataSave: Codable {
    
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case title
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
    }
    
}

struct TaskData: Codable {
    
    let id: String?
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
    }
    
    //    init(from decoder: Decoder) throws {
    //        let container = try decoder.container(keyedBy: CodingKeys.self)
    //        self.id = try! container.decode(String.self, forKey: .id)
    //        self.title = try! container.decode(String.self, forKey: .title)
    //    }
    //
    //    init() {
    //        self.id = ""
    //        self.title = ""
    //    }
    
    //    init(json: [String: Any]) {
    //        id = json["id"] as? String ?? ""
    //        title = json["title"] as? String ?? ""
    //    }
    
}
