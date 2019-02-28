import RxSwift
import RxCocoa
import RxDataSources

//struct SectionViewModel {
//    var header: String
//    var items: [ScheduleViewModel]
//}
//
//extension SectionViewModel: SectionModelType {
//    typealias Item = ScheduleViewModel
//
//    init(original: SectionViewModel, items: [ScheduleViewModel]) {
//        self = original
//        self.items = items
//    }
//}

class MainViewModel {
    
//    let scheduleItems = Variable<[SectionViewModel]>([])
//    let disposeBag = DisposeBag()
//
//    init() {
//        Service().loadSchedule().subscribe(onNext: { [weak self] schedules in
//
//            var scheduleViewModels = schedules.sorted { $0.start < $1.start }
//                .map { ScheduleViewModel.init(with: $0) }
//
//            for i in 0..<scheduleViewModels.count-1 {
//                guard let prevDate = scheduleViewModels[i].endDate, let nextDate = scheduleViewModels[i+1].startDate else { return }
//                if prevDate > nextDate {
//                    scheduleViewModels[i].isCollision = true
//                    scheduleViewModels[i+1].isCollision = true
//                }
//            }
//
//            self?.scheduleItems.value = Dictionary(grouping: scheduleViewModels, by: { $0.dayString })
//                .map { SectionViewModel(header: $0.key, items: $0.value) }
//                .sorted { $0.header < $1.header }
//            }, onError: { [weak self] error in
//                self?.scheduleItems.value = []
//        }).disposed(by: disposeBag)
//    }
    
}
