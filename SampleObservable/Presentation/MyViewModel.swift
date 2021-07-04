//
//  MyViewModel.swift
//  SampleObservable
//
//  Created by 김종권 on 2021/07/05.
//

import Foundation

protocol MyViewModelInput {
    func didTapButton()
}

protocol MyViewModelOutput {
    var count: Observable<Int> { get }
}

protocol MyViewModel: MyViewModelInput, MyViewModelOutput {}

class DefaultMyViewModel: MyViewModel {

    struct Dependencies {
        let initCount: Int
    }

    // MARK: - OUTPUT

    var count: Observable<Int> = Observable(0)

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    private func updateCount() {
        let currentCount = count.value != 0 ? count.value : dependencies.initCount
        count.value = currentCount + 1
    }
}

// MARK: - INPUT

extension DefaultMyViewModel {
    func didTapButton() {
        updateCount()
    }
}
