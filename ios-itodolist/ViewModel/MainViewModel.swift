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
            if item.id != cellViewModel.id {
                return item
            }
            
            print("tap idtask:", item.idtask)
            
            var newViewModel = item
            newViewModel.count += 1
            return newViewModel
        }
        
        itemPublisher.accept(nextItems)
    }
    
    private func setDebugItems() {
        
        apiController = ApiController()
        
        apiController?.getTasks(success: {modelTaskData in
            print("mod", modelTaskData)
            self.itemPublisher.accept(modelTaskData)
        }, failure: { errorMsg in
            print(errorMsg)
        })
        
//        apiController?.getTasksData(success: {modelTaskData in
//            //print(modelTaskData)
//            self.itemPublisher.accept(modelTaskData)
//        }, failure: { errorMsg in
//            print(errorMsg)
//        })
        
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
