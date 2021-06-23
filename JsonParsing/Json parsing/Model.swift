//
//  Model.swift
//  TestApps
//
//  Created by Saddam on 23/6/21.
//

import Foundation

/// Make model according to json formetter

struct allData: Codable{
    var myData: [allItems]
    var status: String
}

struct allItems: Codable{
    var title: String
    var items: [String]
}
