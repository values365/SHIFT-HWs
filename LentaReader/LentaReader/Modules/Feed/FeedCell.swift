//
//  FeedCell.swift
//  LentaReader
//
//  Created by Владислав Банков on 03.03.2021.
//

import UIKit
import SnapKit

final class FeedCell: UITableViewCell {

	// MARK: - Properties

	static let identifier = "feed-cell"

	// MARK: - UI Components

	private let containerView = UIView()
	private let contentImage = UIImageView()
	private let titleLabel = UILabel()
	private let descriptionLabel = UILabel()

	// MARK: - Init

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		setupAppearances()
		setupLayouts()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
		if selected {
			self.setSelected(false, animated: false)
		}
    }

	// MARK: - Public Methods

	func setTitle(_ title: String) {
		titleLabel.text = title
	}

	func setImage(_ image: UIImage) {
		contentImage.image = image
	}

	func setDescription(_ description: String) {
		descriptionLabel.text = description
	}
}

// MARK: - Appearance & Layout

private extension FeedCell {
	func setupAppearances() {
		containerView.backgroundColor = .systemGray5
		containerView.layer.cornerRadius = Constants.itemCornerRadius.rawValue
		contentImage.layer.cornerRadius = Constants.itemCornerRadius.rawValue

		titleLabel.textColor = .systemGray
		titleLabel.font = .boldSystemFont(ofSize: Constants.regularFontSize.rawValue)

		descriptionLabel.numberOfLines = 0
		descriptionLabel.textColor = .systemGray
		descriptionLabel.font = .systemFont(ofSize: Constants.defaultFontSize.rawValue)
	}

	func setupLayouts() {
		addSubview(containerView)
		containerView.snp.makeConstraints { make in
			make.top.leading.trailing.bottom.equalToSuperview().inset(Constants.appleSpacing.rawValue)
		}

		containerView.addSubview(contentImage)
		contentImage.snp.makeConstraints { make in
			make.top.leading.trailing.equalToSuperview()
			make.height.equalToSuperview().multipliedBy(Constants.imageSizeMultiplier.rawValue)
		}

		containerView.addSubview(titleLabel)
		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(contentImage.snp.bottom).offset(Constants.appleSpacing.rawValue)
			make.leading.trailing.equalToSuperview().inset(Constants.appleSpacing.rawValue)
		}

		containerView.addSubview(descriptionLabel)
		descriptionLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom)
			make.leading.trailing.equalToSuperview().inset(Constants.appleSpacing.rawValue)
			make.bottom.equalToSuperview().offset(-Constants.appleSpacing.rawValue)
		}
	}
}
