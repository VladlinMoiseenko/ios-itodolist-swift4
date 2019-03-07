import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Alamofire
import Foundation
import RxAlamofire

protocol ViewModelOutputs {
    var items: BehaviorRelay<[SectionModel]> { get }
    func tapped(cellViewModel: TableCellViewModelTask)
}

class MainViewModel: ViewModelOutputs  {
    
    var apiController: ApiController?
    
    var items = BehaviorRelay<[SectionModel]>(value: [])
    
    private let viewModels = BehaviorRelay<[TableCellViewModelTask]>(value: [])
    private let itemPublisher = PublishRelay<[TableCellViewModelTask]>()
    
    private var disposeBag: DisposeBag!
    
    init() {
        bindRx()
        setItems()
    }
    
    func tapped(cellViewModel: TableCellViewModelTask) {
        
        let nextItems = viewModels.value.enumerated().map { (offset, item) -> TableCellViewModelTask in
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
    
//    private func setupGestures() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
//        tapGesture.numberOfTapsRequired = 1
//        //button.addGestureRecognizer(tapGesture)
//    }
    
    
    
    private func setItems() {
        
        apiController = ApiController()
        
        apiController?.getTasks(success: {modelTaskData in
            self.itemPublisher.accept(modelTaskData)
        }, failure: { errorMsg in
            print(errorMsg)
        })
        
    }
    
    func apiLogout() {
        apiController = ApiController()
        apiController?.logout(success: {modelLogout in
            if modelLogout.status == 1 {
                UserDefaults.standard.set("empty", forKey: "accessToken")
            }
        }, failure: { errorMsg in
            print(errorMsg)
        })
    }

    
}

extension MainViewModel {
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
    
    private func updateItem(viewModel: TableCellViewModelTask) {
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
    var viewModel: TableCellViewModelTask
    
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
