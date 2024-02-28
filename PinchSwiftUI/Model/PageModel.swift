//
//  PageModel.swift
//  PinchSwiftUI
//
//  Created by Bilal on 28.02.2024.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
