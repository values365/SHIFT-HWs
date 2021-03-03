//
//  WelcomeView.swift
//  LentaReader
//
//  Created by Владислав Банков on 02.03.2021.
//

import UIKit
import SnapKit

final class WelcomeView: UIView {

	var delegate: IWelcomeViewController?

	private let scrollView = UIScrollView()
	private let titleLabel = UILabel()
	private let subTitleLabel = UILabel()
	private let logoImage = UIImageView()
	private let entryButton = UIButton()

	init() {
		super.init(frame: .zero)

		backgroundColor = .systemBackground
		entryButton.addTarget(self, action: #selector(entryButtonDidTapped), for: .touchUpInside)
		setupAppearance()
		setupLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension WelcomeView {
	func setupAppearance() {
		titleLabel.text = StringConstants.titleText.rawValue
		titleLabel.textAlignment = .center
		titleLabel.font = Fonts.timesTitleFont
		titleLabel.textColor = Colors.titleColor

		subTitleLabel.text = StringConstants.subTitleText.rawValue
		subTitleLabel.textAlignment = .center
		subTitleLabel.font = Fonts.timesCommonFont
		subTitleLabel.textColor = Colors.subTitleColor

		logoImage.image = UIImage(named: "logo")

		entryButton.setTitle(StringConstants.buttonText.rawValue, for: .normal)
		entryButton.titleLabel?.font = Fonts.timesCommonFont
		entryButton.backgroundColor = .systemBackground
		entryButton.setTitleColor(Colors.buttonTextColor, for: .normal)
		entryButton.layer.borderColor = Colors.buttonBorderColor
		entryButton.layer.borderWidth = Constants.buttonBorderWidth.rawValue
		entryButton.layer.cornerRadius = Constants.entryButtonHeight.rawValue / 2
	}

	func setupLayout() {
		addSubview(scrollView)
		scrollView.snp.makeConstraints { make in
			make.top.bottom.equalTo(safeAreaLayoutGuide)
			make.leading.trailing.equalToSuperview()
		}

		scrollView.addSubview(titleLabel)
		titleLabel.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.greaterThanOrEqualTo(scrollView.snp.top).offset(Constants.largeSpacing.rawValue)
		}

		scrollView.addSubview(subTitleLabel)
		subTitleLabel.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalTo(titleLabel.snp.bottom).offset(Constants.regularSpacing.rawValue)
		}

		scrollView.addSubview(logoImage)
		logoImage.snp.makeConstraints { make in
			make.top.equalTo(subTitleLabel.snp.bottom).offset(Constants.regularSpacing.rawValue + Constants.defaultSpacing.rawValue)
			make.height.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(Constants.imageSizeMultiplier.rawValue)
			make.centerX.equalToSuperview()
		}

		scrollView.addSubview(entryButton)
		entryButton.snp.makeConstraints { make in
			make.top.greaterThanOrEqualTo(logoImage.snp.bottom).multipliedBy(Constants.spacingMultiplier.rawValue)
			make.bottom.equalTo(scrollView.snp.bottom).offset(-Constants.defaultSpacing.rawValue)
			make.centerX.equalToSuperview()
			make.height.equalTo(Constants.entryButtonHeight.rawValue)
			make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(Constants.entryButtonWidthMultiplier.rawValue)
		}
	}

	@objc func entryButtonDidTapped() {
		delegate?.tapButtonHandler?()
	}
}
