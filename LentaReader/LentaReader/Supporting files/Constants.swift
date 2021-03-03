//
//  Constants.swift
//  LentaReader
//
//  Created by Владислав Банков on 02.03.2021.
//

import UIKit

enum Constants: CGFloat {
	case rowHeight = 300

	case titleFontSize = 30
	case defaultFontSize = 15
	case regularFontSize = 20

	case appleSpacing = 8
	case defaultSpacing = 16
	case regularSpacing = 32
	case largeSpacing = 82
	case spacingMultiplier = 1.3

	case imageSizeMultiplier = 0.65

	case entryButtonHeight = 50
	case entryButtonWidthMultiplier = 0.75
	case buttonBorderWidth = 0.8

	case itemCornerRadius = 10
}

enum StringConstants: String {
	case titleText = "LENTA"
	case subTitleText = "Новости в России и в мире"
	case buttonText = "Читать Новости"

	case sourceURL = "https://lenta.ru/rss/articles"
}
