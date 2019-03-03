struct Logout: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case status
    }
    
    let status: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try! container.decode(Int.self, forKey: .status)
    }
    
    init() {
        self.status = 0
    }
    
    init(jsonDict: [String: Any]) {
        status = jsonDict["status"] as? Int ?? 0
    }
    
}
