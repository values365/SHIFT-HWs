//
//  FeedView.swift
//  LentaReader
//
//  Created by Владислав Банков on 02.03.2021.
//

import UIKit
import SnapKit

final class FeedView: UIView {

	// MARK: - Properties

	var tableViewDataSource: UITableViewDataSource? {
		get { tableView.dataSource }
		set { tableView.dataSource = newValue }
	}

	var tableViewDelegate: UITableViewDelegate? {
		get { tableView.delegate }
		set { tableView.delegate = newValue }
	}

	var delegate: IFeedViewController?

	// MARK: - UI Components

	private let tableView = UITableView()

	// MARK: - Init

	init() {
		super.init(frame: .zero)

		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public Methods

	func reloadRows(at index: IndexPath) {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return assertionFailure("self reference is nil") }
			self.tableView.reloadRows(at: [index], with: .fade)
		}
	}
}

// MARK: - Internal Methods

private extension FeedView {
	func setupView() {
		backgroundColor = .systemBackground
		tableView.register(FeedCell.self, forCellReuseIdentifier: FeedCell.identifier)
		tableView.separatorStyle = .none
		setupTableViewLayout()
	}

	func setupTableViewLayout() {
		addSubview(tableView)
		tableView.snp.makeConstraints { make in make.top.bottom.leading.trailing.equalToSuperview() }
	}
}
