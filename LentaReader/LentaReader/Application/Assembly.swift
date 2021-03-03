//
//  Assembly.swift
//  LentaReader
//
//  Created by Владислав Банков on 02.03.2021.
//

import Foundation

enum Assembly {
	static func initWelcomeModule() -> WelcomeViewController {
		WelcomeViewController(presenter: WelcomePresenter())
	}

	static func initFeedModule() -> FeedViewController {
		FeedViewController(presenter: FeedPresenter())
	}
}
