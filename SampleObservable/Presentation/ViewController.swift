//
//  ViewController.swift
//  SampleObservable
//
//  Created by 김종권 on 2021/07/05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countButton: UIButton!

    let viewModel: MyViewModel = DefaultMyViewModel(dependencies: .init(initCount: 0))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind(to: viewModel)
    }

    private func setupView() {
        countButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    private func bind(to viewModel: MyViewModel) {
        viewModel.count.observe(on: self, observerBlock: { [weak self] in self?.updateCount(count: $0) })
    }

    private func updateCount(count: Int) {
        countLabel.text = "\(count)"
    }
}

// MARK: - INPUT

extension ViewController {
    @objc private func didTapButton() {
        viewModel.didTapButton()
    }
}
