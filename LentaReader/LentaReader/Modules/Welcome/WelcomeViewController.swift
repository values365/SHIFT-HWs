//
//  WelcomeViewController.swift
//  LentaReader
//
//  Created by Владислав Банков on 02.03.2021.
//

import UIKit

protocol IWelcomeViewController {
	var tapButtonHandler: (() -> Void)? { get set }
}

final class WelcomeViewController: UIViewController {
	var tapButtonHandler: (() -> Void)?
}

extension WelcomeViewController: IWelcomeViewController {}
