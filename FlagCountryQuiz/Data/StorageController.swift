//
//  StorageController.swift
//  Singleton
//
//  Created by Matteo Manferdini on 16/01/2019.
//  Copyright © 2019 Matteo Manferdini. All rights reserved.
//

import Foundation

class StorageController {
	private let userFileURL = FileManager.default
		.urls(for: .documentDirectory, in: .userDomainMask)
		.first!
		.appendingPathComponent("User")
		.appendingPathExtension("plist")
    static let shared = StorageController()
	
	init() {
		guard fetchUser() == nil else {
			return
		}
        let user = User(name: "", flagCount: 1, points: 1, timeCount: 1)
		save(user)
	}
	
	func fetchUser() -> User? {
		guard let data = try? Data(contentsOf: userFileURL) else {
			return nil
		}
		let decoder = PropertyListDecoder()
		return try? decoder.decode(User.self, from: data)
	}
	
	func save(_ user: User) {
		let encoder = PropertyListEncoder()
		if let data = try? encoder.encode(user) {
			try? data.write(to: userFileURL)
		}
	}
}
