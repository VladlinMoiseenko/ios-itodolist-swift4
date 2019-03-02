import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Alamofire
import Foundation
import RxAlamofire

protocol ViewModelOutputs {
    var items: BehaviorRelay<[SectionModel]> { get }
    func tapped(cellViewModel: TableCellViewModel)
}

class ViewModel: ViewModelOutputs  {
    
    var apiController: ApiController?
    
    var items = BehaviorRelay<[SectionModel]>(value: [])
    
    private let viewModels = BehaviorRelay<[TableCellViewModel]>(value: [])
    private let itemPublisher = PublishRelay<[TableCellViewModel]>()
    
    private var disposeBag: DisposeBag!
    
    init() {
        bindRx()
        setDebugItems()
    }
    
    func tapped(cellViewModel: TableCellViewModel) {
        
        let nextItems = viewModels.value.enumerated().map { (offset, item) -> TableCellViewModel in
//            if item.id != cellViewModel.id {
//                return item
//            }
            
            var newViewModel = item
            newViewModel.count += 1
            return newViewModel
        }
        
        itemPublisher.accept(nextItems)
    }
    
//    private func setDebugItems() {
//        let items = (0...2).map { num -> TableCellViewModel in
//            let name = "Tester \(num)"
//            let age = 3 * (num + 1)
//            let count = 0
//            return TableCellViewModel(name: name,
//                                      age: age,
//                                      count: count
//            )
//        }
//        itemPublisher.accept(items)
//    }
    
    private func setDebugItems() {
        
        getTasksData(success: {modelTaskData in
            print(modelTaskData)
            //return modelTaskData
            self.itemPublisher.accept([modelTaskData])
            }, failure: { errorMsg in
                print(errorMsg)
            })

        
//            let items = (0...2).map { num -> TableCellViewModel in
//                let id = "id"
//                let title = "Tester \(num)"
//                let count = 0
//                return TableCellViewModel(id: id,
//                                          title: title,
//                                          count: count
//                )
//            }
//            self.itemPublisher.accept(items)
            

    }
    
    func getTasksData(success: @escaping (TableCellViewModel) -> Void, failure: @escaping (String) -> Void) {
        RxAlamofire.requestJSON(.get, "http://apitdlist.dev.vladlin.ru/v1/task")
            .observeOn(MainScheduler.instance)
            .map { (r, json) -> [String: Any] in
                guard let jsonDict = json as? [String: Any] else {
                    return [:]
                }
                return jsonDict
            }
            .subscribe(onNext: { jsonDict in
                //let model = Task(jsonDict: jsonDict)
                
                if let array = jsonDict["data"] as? [Any] {
                    for object in array {
                        if let ob = object as? [String: Any] {
                            let dmodel = TableCellViewModel(json: ob)
                            success(dmodel)
                        }
                    }
                }
                
            }, onError: { error in
                failure("Error")
            })
            .disposed(by: disposeBag)
    }
    
    
}

extension ViewModel {
    private func bindRx() {
        self.disposeBag = DisposeBag()
        
        DataSubject.AddedNotification.subscribe(onNext: { [weak self] cellViewModel in
            //print("new data: \(cellViewModel)")
            self?.updateItem(viewModel: cellViewModel)
        }).disposed(by: disposeBag)
        
        itemPublisher.subscribe(onNext: { [weak self] items in
            guard let strongSelf = self else { return }
            
            strongSelf.viewModels.accept(items)
            
            let elements = items.map { SectionItem(viewModel: $0) }
            strongSelf.items.accept([SectionModel(model: .section0, items: elements)])
            
        }).disposed(by: disposeBag)
    }
    
    private func updateItem(viewModel: TableCellViewModel) {
        var preItems = viewModels.value
        preItems.append(viewModel)
        itemPublisher.accept(preItems)
    }
}

// RxDataSources
typealias SectionModel = AnimatableSectionModel<SectionID, SectionItem>

// SectionID
enum SectionID: String, IdentifiableType {
    case section0
    
    var identity: String {
        return rawValue
    }
}

// SectionItem
struct SectionItem: IdentifiableType, Equatable {
    var viewModel: TableCellViewModel
    
    var identity: String {
        return viewModel.id
    }
    
    var itemCount: Int {
        return viewModel.count
    }
    
    static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
        return lhs.identity == rhs.identity && lhs.viewModel.count == rhs.viewModel.count
    }
    
}
