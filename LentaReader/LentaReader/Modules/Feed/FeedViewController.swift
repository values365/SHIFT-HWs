//
//  FeedViewController.swift
//  LentaReader
//
//  Created by Владислав Банков on 02.03.2021.
//

import UIKit

protocol IFeedViewController: AnyObject {
	func reloadRows(at index: IndexPath)
}

final class FeedViewController: UIViewController {

	private let presenter: IFeedPresenter
	private let feedView = FeedView()

	init(presenter: IFeedPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = feedView
		feedView.tableViewDataSource = self
		feedView.tableViewDelegate = self
		feedView.delegate = self
		presenter.viewDidLoad(with: self)
	}
}

// MARK: - Table View Data Source

extension FeedViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let model = presenter.model else {
			assertionFailure("Model is nil (model access trying from UITableViewDataSource)")
			return 0
		}
		return model.feedImages.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
		guard let model = presenter.model else {
			assertionFailure("Model is nil (model access trying from UITableViewDataSource)") 
			return cell;
		}
		cell.setImage(model.feedImages[indexPath.row])
		cell.setTitle(model.feeds[indexPath.row])
		cell.setDescription(model.descriptions[indexPath.row].replacingOccurrences(of: "\n", with: ""))
		return cell
	}
}

// MARK: - Table View Delegate

extension FeedViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		Constants.rowHeight.rawValue
	}
}

// MARK: - IFeedViewController

extension FeedViewController: IFeedViewController {
	func reloadRows(at index: IndexPath) {
		feedView.reloadRows(at: index)
	}
}
