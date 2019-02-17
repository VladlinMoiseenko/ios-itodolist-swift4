import Foundation

fileprivate let format = "MMMM d, yyyy h:mm a"

struct Schedule: Decodable {
    let title: String
    let start: String
    let end: String
    
    var startDate: String? {
        return start
    }
    
    var endDate: String? {
        return end
    }
}
