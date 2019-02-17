import Foundation

fileprivate let dayFormat = "MMMM d"
fileprivate let timeFormat = "h:mma"

protocol ScheduleViewModelProtocol {
    var title: String { get }
    var startDate: String? { get }
    var endDate: String? { get }
    
    var timeString: String { get }
    var dayString: String { get }
    var isCollision: Bool { get }
}

struct ScheduleViewModel: ScheduleViewModelProtocol {
    var title: String
    var startDate: String?
    var endDate: String?
    
    var timeString: String {
        guard let startDate = startDate, let endDate = endDate else { return "" }
        return startDate
    }
    
    var dayString: String {
        guard let startDate = startDate else { return "" }
        return startDate
    }
    
    var isCollision: Bool = false
    
    init(with model: Schedule) {
        title = model.title
        startDate = model.startDate
        endDate = model.endDate
    }
}
