import Foundation
import RxSwift
import Alamofire

typealias LoadScheduleResponse = Observable<[Schedule]>

protocol ServiceProtocol {
    func loadSchedule() -> LoadScheduleResponse
}

class Service: ServiceProtocol {
    
    /// load schedule
    ///
    /// - Returns: Observable<[Schedule]>
    func loadSchedule() -> LoadScheduleResponse {
        let url = Bundle.main.url(forResource: "mock", withExtension: "json")
        
        return LoadScheduleResponse.create { observer -> Disposable in
            let request = Alamofire.request(url!).responseData { responseData in
                switch responseData.result {
                case .success(let value):
                    do {
                        let jsonData = try JSONDecoder().decode([Schedule].self, from: value)
                        observer.onNext(jsonData)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create(with: {
                request.cancel()
            })
        }
    }
}
