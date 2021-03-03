//
//  FeedPresenter.swift
//  LentaReader
//
//  Created by Владислав Банков on 02.03.2021.
//

import UIKit

protocol IFeedPresenter {
	var model: FeedModel? { get }
	func viewDidLoad(with viewController: IFeedViewController)
}

final class FeedPresenter {

	var model: FeedModel?

	private weak var viewController: IFeedViewController?
}

private extension FeedPresenter {
	func getModel() {
		guard let url = URL(string: StringConstants.sourceURL.rawValue) else {
			return assertionFailure("couldn't get 'URL' from source 'String'")
		}
		let parser = XMLParserManager(with: url)
		let feeds = parser.allFeeds()
		guard let feedImages = makeCollectionDefault(with: feeds.count) else { return assertionFailure("couldn't find the default image") }
		let descriptions = parser.allDescriptions()
		model = FeedModel(feeds: feeds, feedImages: feedImages, descriptions: descriptions)
		loadData(from: parser.allImages())
	}

	func loadData(from urls: [String]) {
		DispatchQueue.global(qos: .userInteractive).async { [weak self] in
			guard let self = self else { return assertionFailure("self reference is nil") }
			for index in 0..<urls.count {
				guard let url = URL(string: urls[index]) else { return assertionFailure("couldn't cast 'String' into 'URL'") }
				guard let data = try? Data(contentsOf: url) else { return assertionFailure("couldn't fetch data from 'URL'") }
				guard let image = UIImage(data: data) else { return assertionFailure("couldn't build an 'UIImage' from 'Data'") }
				self.model?.feedImages[index] = image
				self.viewController?.reloadRows(at: IndexPath(row: index, section: 0))
			}
		}
	}

	func makeCollectionDefault(with feedItemCount: Int) -> [UIImage]? {
		var images: [UIImage] = []
		guard let image = UIImage(named: "waiting") else { return nil }
		for _ in 0..<feedItemCount { images.append(image) }
		return images
	}
}

extension FeedPresenter: IFeedPresenter {
	func viewDidLoad(with viewController: IFeedViewController) {
		self.viewController = viewController
		getModel()
	}
}
