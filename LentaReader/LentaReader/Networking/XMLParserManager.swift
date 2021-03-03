//
//  XMLParserManager.swift
//  LentaReader
//
//  Created by Владислав Банков on 02.03.2021.
//

import Foundation

final class XMLParserManager: NSObject, XMLParserDelegate {

	// MARK: - Properties

	private var parser = XMLParser()
	private var feeds: [String] = []
	private var images: [String] = []
	private var descriptions: [String] = []
	private var element = ""
	private var title = ""
	private var descript = ""

	init(with url: URL) {
		super.init()
		startParsing(url)
	}

	private func startParsing(_ url: URL) {
		feeds = []
		guard let parser = XMLParser(contentsOf: url) else {
			return assertionFailure("couldn't build 'XMLParser' from 'URL'")
		}
		parser.delegate = self
		parser.shouldProcessNamespaces = false
		parser.shouldReportNamespacePrefixes = false
		parser.shouldResolveExternalEntities = false
		parser.parse()
	}

	// MARK: - Public Methods

	func allFeeds() -> [String] { feeds }

	func allImages() -> [String] { images }

	func allDescriptions() -> [String] { descriptions }

	// MARK: - XMLParserDelegate

	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
		element = elementName
		if element == "item" {
			title = ""
			descript = ""
		} else if element == "enclosure" {
			if let urlString = attributeDict["url"] {
				images.append(urlString)
			}
		}
	}

	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		if (elementName as NSString).isEqual(to: "item") {
			if title != "" {
				feeds.append(title)
			}
			if descript != "" {
				descriptions.append(descript)
			}
		}
	}

	func parser(_ parser: XMLParser, foundCharacters string: String) {
		if element == "title" {
			title.append(string)
		} else if element == "description" {
			descript.append(string)
		}
	}
}
