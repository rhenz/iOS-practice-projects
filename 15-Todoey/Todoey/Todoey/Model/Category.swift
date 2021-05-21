//
//  Category.swift
//  Todoey
//
//  Created by JLCS on 4/11/21.
//

import Foundation
import RealmSwift
import ChameleonFramework

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    @objc dynamic var categoryCellColor: String = ""
}
