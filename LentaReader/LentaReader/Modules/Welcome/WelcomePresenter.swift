//
//  WelcomePresenter.swift
//  LentaReader
//
//  Created by Владислав Банков on 02.03.2021.
//

import Foundation

protocol IWelcomePresenter {
	func viewDidLoad(with viewController: IWelcomeViewController)
}

final class WelcomePresenter {
	private weak var viewController: IWelcomeViewController?

}

extension WelcomePresenter: IWelcomePresenter {
	func viewDidLoad(with viewController: IWelcomeViewController) {
		self.viewController = viewController
		viewController.tapButtonHandler = { [weak self] in
			guard let self = self else { return assertionFailure() }
			self.viewController?.navigationController?.pushViewController(Assembly.initFeedModule(), animated: true)
		}
	}
}
