//
//  View.swift
//  SHIFT-HW#1
//
//  Created by Владислав Банков on 27.02.2021.
//

import UIKit

final class View: UIView {

	var delegate: IViewController?

	private let outputLabel = UILabel()
	private let inputField = UITextField()

	init() {
		super.init(frame: .zero)

		let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		addGestureRecognizer(tap)
		inputField.delegate = self
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setField(with value: String) {
		inputField.text = value
	}

	func setLabel(with value: String) {
		outputLabel.text = value
	}
}

// MARK: - Internal Methods

private extension View {
	func getInput() {
		guard let input = inputField.text else { return }
		guard let delegate = delegate else { return }
		delegate.throwInput(whichIs: input)
	}

	@objc func dismissKeyboard() {
		endEditing(true)
		getInput()
	}
}

// MARK: - Appearance & Layout

private extension View {
	func setupView() {
		setupAppearance()
		setupLayout()
	}

	func setupAppearance() {
		backgroundColor = .systemTeal

		outputLabel.text = "Введите дату в формате:"
		outputLabel.numberOfLines = 0
		outputLabel.font = .systemFont(ofSize: Constants.fontSize.rawValue)
		outputLabel.textAlignment = .center
		outputLabel.textColor = .systemIndigo

		inputField.borderStyle = .roundedRect
		inputField.placeholder = "ДД.ММ.ГГГГ"
		inputField.textAlignment = .center
		inputField.keyboardType = .numbersAndPunctuation
	}

	func setupLayout() {
		addSubview(inputField)
		addSubview(outputLabel)
		inputField.translatesAutoresizingMaskIntoConstraints = false
		outputLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			inputField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -Constants.defaultSpacing.rawValue),
			inputField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.bigSpacing.rawValue),
			inputField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Constants.bigSpacing.rawValue),

			outputLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.regularSpacing.rawValue),
			outputLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Constants.regularSpacing.rawValue),
			outputLabel.bottomAnchor.constraint(equalTo: inputField.topAnchor, constant: -Constants.regularSpacing.rawValue)
		])
	}
}

extension View: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		endEditing(true)
		getInput()
		return false
	}
}

enum Constants: CGFloat {
	case fontSize = 21

	case defaultSpacing = 16
	case regularSpacing = 32
	case bigSpacing = 64
}

