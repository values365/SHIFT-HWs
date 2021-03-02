//
//  ViewController.swift
//  SHIFT-HW#1
//
//  Created by Владислав Банков on 27.02.2021.
//

import UIKit

protocol IViewController {
	func throwInput(whichIs input: String)
}

final class ViewController: UIViewController {

	private let monthDictionary = [1: "января", 2: "февраля", 3: "марта", 4: "апреля", 5: "мая", 6: "июня", 7: "июля", 8: "августа", 9: "сентября", 10: "октября", 11: "ноября", 12: "декабря"]

	private let mainView = View()

	override func loadView() {
		view = mainView
		mainView.delegate = self
	}
}

extension ViewController: IViewController {
	func throwInput(whichIs input: String) {
		guard let intValues = giveMeInts(from: input) else {
			showWarning()
			mainView.setField(with: "")
			return
		}
		mainView.setLabel(with: makeFinalMessage(with: intValues))
	}
}

private extension ViewController {
	func makeFinalMessage(with values: (Int, Int, Int)) -> String {
		let decade = whatDecadeIs(day: values.0)
		let month = monthDictionary[values.1]
		let yearType = whatYearIs(year: values.2)
		return "\(decade) декада \(month!), \(yearType) года"
	}

	func whatDecadeIs(day: Int) -> String {
		if day < 11 { return "первая" }
		if day < 21 { return "вторая" } else { return "третья" }
	}

	func whatYearIs(year: Int) -> String {
		if year % 4 == 0 {
			if year % 100 == 0 {
				if year % 400 == 0 {
					return "високосного"
				} else { return "невисокосного" }
			} else { return "високосного"}
		} else { return "невисокосного" }
	}

	func giveMeInts(from input: String) -> (Int, Int, Int)? {
		guard input.count == 10 else { return nil }
		guard let dayValue = Int(input.prefix(2)),
			  dayValue > 0 && dayValue < 32 else { return nil }
		guard let monthValue = Int(input.prefix(5).suffix(2)),
			  monthValue > 0 && monthValue < 13 else { return nil }
		guard let yearValue = Int(input.suffix(4)),
			  yearValue > 0 else { return nil }
		return (dayValue, monthValue, yearValue)
	}

	func showWarning() {
		let alert = UIAlertController(title: "Ошибка", message: "Дата не соотвествует требуемому формату", preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .cancel)
		alert.addAction(okAction)
		self.present(alert, animated: true)
	}
}

