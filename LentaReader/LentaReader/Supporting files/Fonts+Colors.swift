//
//  Colors.swift
//  LentaReader
//
//  Created by Владислав Банков on 02.03.2021.
//

import UIKit

enum Fonts {
	static let timesTitleFont = UIFont(name: "Times", size: Constants.titleFontSize.rawValue)
	static let timesCommonFont = UIFont(name: "Times", size: Constants.defaultFontSize.rawValue)
}

enum Colors {
	static let titleColor = UIColor(red: 60 / 255, green: 60 / 255, blue: 60 / 255, alpha: 1)
	static let subTitleColor = UIColor(red: 151 / 255, green: 151 / 255, blue: 151 / 255, alpha: 1)
	static let buttonTextColor = UIColor(red: 124 / 255, green: 125 / 255, blue: 126 / 255, alpha: 1)
	static let buttonBorderColor = CGColor(red: 196 / 255, green: 196 / 255, blue: 196 / 255, alpha: 1)
}
