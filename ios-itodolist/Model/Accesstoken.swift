struct Accesstoken: Decodable {
    
    let status: Int
    let accessToken: String
    let expiresAt: Int
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
    enum DataCodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresAt = "expires_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try! container.decode(Int.self, forKey: .status)
        
        let dataContainer = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        self.accessToken = try dataContainer.decode(String.self, forKey: .accessToken)
        self.expiresAt = try dataContainer.decode(Int.self, forKey: .expiresAt)
    }
    
    init() {
        self.status = 0
        self.accessToken = ""
        self.expiresAt = 0
    }
    
    init(jsonDict: [String: Any]) {
        status = jsonDict["status"] as? Int ?? 0
        accessToken = jsonDict["accessToken"] as? String ?? ""
        expiresAt = jsonDict["expiresAt"] as? Int ?? 0
    }
    
}
