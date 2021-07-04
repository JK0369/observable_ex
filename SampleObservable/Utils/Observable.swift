//
//  Observable.swift
//  ObservableEx
//
//  Created by 김종권 on 2021/07/05.
//

import Foundation

public final class Observable<T> {

    struct Observer<T> {
        weak var observer: AnyObject?
        let block: (T) -> Void
    }

    private var observers = [Observer<T>]()

    public var value: T {
        didSet { notifyObservers() } // stord property에 값을 지정하면 -> block실행
    }

    public init(_ value: T) {
        self.value = value
    }

    /// observer를 추가: value값과 block 추가
    public func observe(on observer: AnyObject, observerBlock: @escaping (T) -> Void) {
        observers.append(Observer(observer: observer, block: observerBlock))
        observerBlock(value)
    }

    public func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }

    private func notifyObservers() {
        for observer in observers {
            DispatchQueue.main.async { observer.block(self.value) }
        }
    }
}
