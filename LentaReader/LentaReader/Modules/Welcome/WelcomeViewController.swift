//
//  WelcomeViewController.swift
//  LentaReader
//
//  Created by Владислав Банков on 02.03.2021.
//

import UIKit

protocol IWelcomeViewController: UIViewController {
	var tapButtonHandler: (() -> Void)? { get set }
}

final class WelcomeViewController: UIViewController {

	var tapButtonHandler: (() -> Void)?

	private let presenter: IWelcomePresenter
	private let welcomeView = WelcomeView()

	init(presenter: IWelcomePresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = welcomeView
		welcomeView.delegate = self
		presenter.viewDidLoad(with: self)
	}
}

extension WelcomeViewController: IWelcomeViewController {}
